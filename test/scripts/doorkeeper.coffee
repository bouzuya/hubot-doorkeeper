{Robot, User, TextMessage} = require 'hubot'
assert = require 'power-assert'
path = require 'path'
sinon = require 'sinon'

describe 'hello', ->
  beforeEach (done) ->
    @sinon = sinon.sandbox.create()
    # for warning: possible EventEmitter memory leak detected.
    # process.on 'uncaughtException'
    @sinon.stub process, 'on', -> null
    @robot = new Robot(path.resolve(__dirname, '..'), 'shell', false, 'hubot')
    @robot.adapter.on 'connected', =>
      @robot.load path.resolve(__dirname, '../../src/scripts')
      done()
    @robot.run()

  afterEach (done) ->
    @robot.brain.on 'close', =>
      @sinon.restore()
      done()
    @robot.shutdown()

  describe 'listeners[0].regex', ->
    beforeEach ->
      @callback = @sinon.spy()
      @robot.listeners[0].callback = @callback

    describe 'receive "@hubot doorkeeper hitoridokusho"', ->
      beforeEach ->
        @sender = new User 'bouzuya', room: 'hitoridokusho'
        message = '@hubot doorkeeper hitoridokusho'
        @robot.adapter.receive new TextMessage(@sender, message)

      it 'calls *doorkeeper* with "@hubot doorkeeper hitoridokusho"', ->
        assert @callback.callCount is 1
        match = @callback.firstCall.args[0].match
        assert match.length is 2
        assert match[0] is '@hubot doorkeeper hitoridokusho'
        assert match[1] is 'hitoridokusho'

  describe 'listeners[0].callback', ->
    beforeEach ->
      @hello = @robot.listeners[0].callback

    describe 'receive "@hubot doorkeeper hitoridokusho"', ->
      beforeEach ->
        @response = [
          event:
            public_url: 'http://hitoridokusho.doorkeeper.jp/events/13976'
            title: 'ひとり読書会 #13 プログラミングの基礎 (9)'
            starts_at: '2014-08-10T10:00:00.000Z'
            ends_at: '2014-08-10T12:00:00.000Z'
            venue_name: 'ひとり読書会 Lingr'
        ]
        @res = @sinon.stub()
        @res.onFirstCall().callsArgWith 0, null, null, JSON.stringify(@response)
        @get = @sinon.stub()
        @get.onFirstCall().returns @res
        @http = @sinon.stub()
        @http.onFirstCall().returns get: @get
        @send = @sinon.spy()
        @hello
          match: ['@hubot doorkeeper hitoridokusho']
          send: @send
          http: @http

      it 'send event info', ->
        assert @send.callCount is 1
        assert @send.firstCall.args[0] is '''
          http://hitoridokusho.doorkeeper.jp/events/13976
          ひとり読書会 #13 プログラミングの基礎 (9)
          2014-08-10T10:00:00.000Z/2014-08-10T12:00:00.000Z
          ひとり読書会 Lingr

        '''
