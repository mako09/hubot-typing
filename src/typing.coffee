# Description
#   Hubot helps touch typing training for Japanese Romaji
#
# Configuration:
#   HUBOT_TYPING_ACTIVATE: 1
#
# Commands:
#   れんしゅう はじめ - activate this script
#   れんしゅう おわり - deactivate this script
#   1 - lowering the level ( less characters )
#   2-7 - word length
#   9 - raising the level ( more characters )
#
# Author:
#   Mako N <mako@pasero.net>
#
# License:
#   Copyright (C) 2018 Mako N
#   Released under the MIT license
#   http://opensource.org/licenses/mit-license.php
#

level =0
maxlevel = 10
length = 3
word = ''
s = []
s[i] = '' for i in [0..maxlevel]

s[0] += 'あいうえおん' for [1..15]
s[1] += 'かきくけこたちつてと' for [1..10]
s[2] += 'さしすせそやゆよ' for [1..10]
s[3] += 'なにぬねのはひふへほ' for [1..8]
s[4] += 'らりるれろ' for [1..8]
s[5] += 'まみむめもわを' for [1..6]
s[6] += '、。ー' for [1..5]
s[7] += 'がぎぐげござじずぜぞ' for [1..5]
s[8] += 'だでどばびぶべぼ'  for [1..3]
s[9] += 'ぢづ'
s[10] += 'ぱぴぷぺぽ' for [1..2]

reward1 = ['😀','😃','😉','🙂','❤','💗','💞','🎀','👌','✌','👏']
reward2 = [' OK! ',' いいね! ',' ばっちり! ',' うまい! ',' じょうず! ']

if process.env.HUBOT_TYPING_ACTIVATE is "1"
  active = 1
else
  active = 0


module.exports = (robot) ->

  robot.hear /(れんしゅう|練習)を?\s?(はじめ|始め|開始|やろ).*/, (msg) ->
    active = 1
    msg.send ( "OK, じゃあ始めよう! 😉" ) 

  robot.hear /(れんしゅう|練習)を?\s?(やめ|止め|終了|おわ|終わ).*/, (msg) ->
    active = 0
    msg.send ( "じゃあ、またね!!! 👋 バイバイ!" )

  robot.hear /^[9９]$/, (msg) ->
    return unless active is 1
    level++
    level = maxlevel if level > maxlevel
    msg.send "レベルを #{level} にします。"

  robot.hear /^[1１]$/, (msg) ->
    return unless active is 1
    level--
    level = 0 if level < 0
    msg.send "レベルを #{level} にします。"

  robot.hear /^([2-7２-７])$/, (msg) ->
    return unless active is 1
    length = msg.match[1]
    msg.send "ことばの長さを #{length} にします。"

  robot.hear /(.*)/, (msg) ->
    return unless active is 1
    msg.send ( ( msg.random reward1 ) + ( msg.random reward2 ) + ( msg.random reward1 ) ) if word == msg.match[1]
    string = ''
    string += s[i] for i in [0..level]
    word = ( msg.random string.split('') for [1..length] ).join('')
    msg.send word
