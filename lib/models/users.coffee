'use strict'
mongoose = require('mongoose')
Schema = mongoose.Schema

UserSchema = new Schema(
  facebookIdentifier: String
  preferences:
    search:
      gameType: Number
      userType: Number
      location: String
      radius: Number
    create:
      gameType: Number
      userType: Number
      fieldType: Number
      balls: Number
      rackets: Number
      skillLevel: Number
      description: String
      location: String
  trustPoints: Number
)

UserSchema.path('preferences.search.gameType').validate ((num) ->
  num == 0 or num == 1
), 'gameType must be either 0 or 1'

UserSchema.path('preferences.search.userType').validate ((num) ->
  num == 0 or num == 1
), 'userType must be either 0 or 1'

UserSchema.path('preferences.search.radius').validate ((num) ->
  num >= 1
), 'radius must be 1 or bigger'

UserSchema.path('preferences.create.gameType').validate ((num) ->
  num == 0 or num == 1
), 'gameType must be either 0 or 1'

UserSchema.path('preferences.create.userType').validate ((num) ->
  num == 0 or num == 1
), 'userType must be either 0 or 1'

UserSchema.path('preferences.create.fieldType').validate ((num) ->
  num >= 0 and num <= 2
), 'fieldType must be either 0, 1 or 2'

UserSchema.path('preferences.create.balls').validate ((num) ->
  num >= 0
), 'balls can\'t be negative'

UserSchema.path('preferences.create.rackets').validate ((num) ->
  num >= 0
), 'rackets can\'t be negative'

UserSchema.path('preferences.create.skillLevel').validate ((num) ->
  num >= 0 and num <= 5
), 'skillLevel has to be between 0 and 5'

mongoose.model 'User', UserSchema