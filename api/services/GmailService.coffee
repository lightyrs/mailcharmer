inbox        = require 'inbox'
{MailParser} = require 'mailparser'

_ = require 'lodash'

module.exports =

  fetch: (options) ->
    @timer = 0
    @interval = 1
    @label = options.label || 'Inbox'
    @username = options.username
    @password = options.password
    @client = @initClient() if not @client
    _.bindAll(@, 'doFetch')

  initClient: ->
    _client = inbox.createConnection false, 'imap.gmail.com', {
      secureConnection: true
      auth:
        user: @username
        pass: @password
    }
    _client.lastfetch = 0
    _client.connect()
    _client.on 'connect', () =>
      _client.openMailbox @label, (e, info) =>
        if e
          console.log e
          return false
        @setTimer @interval
    return _client

  setTimer: (_interval) ->
    timer = setTimeout @doFetch, _interval * 60 * 1000, ((e, mail) ->
      unless e
        mailDetail = ""
        sender = mail.from[0]
        mailDetail += "From: #{sender.name} <#{sender.address}>\n"
        mailDetail += "Subject: #{mail.subject}\n"
        if mail.text
          mailDetail += "\n"
          mailDetail += mail.text
        console.log mailDetail
      ), (() => @setTimer @interval)

  doFetch: (callback, onFinish) ->
    @client.listMessages -10, (e, messages) =>
      maxUID = _.max(_.map messages, (m) -> m.UID)
      if e
        callback e
      else if maxUID <= @client.lastfetch
        callback(new Error "No new mail")
      else
        for message in messages
          if @client.lastfetch < message.UID
            stream = @client.createMessageStream(message.UID)
            mailparser = new MailParser()
            mailparser.on 'end', (mail) ->
              callback(null, mail)
            stream.pipe(mailparser)
        @client.lastfetch = maxUID
      onFinish()
