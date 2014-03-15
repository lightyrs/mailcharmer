module.exports =

  attributes:

    email:
      type: 'email'
      unique: true
      required: true

    refreshToken:
      type: 'text'
      required: false
