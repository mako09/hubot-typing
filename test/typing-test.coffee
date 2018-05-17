Helper = require('hubot-test-helper')
chai = require 'chai'

expect = chai.expect

helper = new Helper('../src/typing.coffee')

describe 'typing', ->
  beforeEach ->
    @room = helper.createRoom()

  afterEach ->
    @room.destroy()

  it 'responds to hello', ->
    @room.user.say('alice', '@hubot hello').then =>
      expect(@room.messages).to.eql [
        ['alice', '@hubot hello']
        ['hubot', '@alice hello!']
      ]

  it 'hears れんしゅう', ->
    @room.user.say('bob', 'れんしゅう').then =>
      expect(@room.messages).to.eql [
        ['bob', 'れんしゅうをはじめるよ']
        ['hubot', 'OK, じゃあ始めよう! 😉']
      ]
