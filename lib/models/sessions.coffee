'use strict'
mongoose = require('mongoose')
Schema = mongoose.Schema

SessionSchema = new Schema(
  identifier: Objectid
  description: String
  userType: Number
  gameType: Number
  fieldType: Number
  skillLevel: Number
  rackets: Number
  balls: Number
  date: Date
  location: String
)

SessionSchema.path('userType').validate ((num) ->
  num == 0 or num == 1
), 'userType must be either 0 or 1'

SessionSchema.path('gameType').validate ((num) ->
  num == 0 or num == 1
), 'userType must be either 0 or 1'

SessionSchema.path('fieldType').validate ((num) ->
  num >= 0 and num <= 2
), 'fieldType must be either 0, 1 or 2'

SessionSchema.path('balls').validate ((num) ->
  num >= 0
), 'balls can\'t be negative'

SessionSchema.path('rackets').validate ((num) ->
  num >= 0
), 'rackets can\'t be negative'

SessionSchema.path('skillLevel').validate ((num) ->
  num >= 0 and num <= 5
), 'skillLevel has to be between 0 and 5'

mongoose.model 'Session', SessionSchema