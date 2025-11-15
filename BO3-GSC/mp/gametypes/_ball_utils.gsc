/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\_ball_utils.gsc
*************************************************/

#namespace ball;

function add_ball_return_trigger(trigger) {
  if(!isDefined(level.ball_return_trigger)) {
    level.ball_return_trigger = [];
  }
  level.ball_return_trigger[level.ball_return_trigger.size] = trigger;
}