'use strict'

mongoose = require('mongoose')
Schema = mongoose.Schema

SessionSchema = new Schema(
  identifier:
    type: Objectid
    required: true
    unique: true
  description: String
  userType:
    type: String
    required: true
    enum: ['S', 'D']
  gameType:
    type: String
    required: true
    enum: ['C', 'R']
  fieldType:
    type: String
    required: true
    enum: ['H', 'G', 'C']
  skillLevel:
    type: Number
    min: 0
    max: 5
    required: true
  rackets:
    type: Number
    min: 0
    required: true
  balls:
    type: Number
    min: 0
    required: true
  date:
    type: Date
    required: true
  location:
    type: String
    required: true
)

mongoose.model 'Session', SessionSchema