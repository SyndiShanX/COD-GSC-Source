/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_79deab1955343d5d.gsc
*************************************************/

#using script_3ab210ea917601e7;
#using script_6617e2f2bb62b52b;
#namespace activity_scoring;

function function_4d4bdc081df1c06b(player, varianttag) {
  if(!isDefined(player.activities.highscores)) {
    player.activities.highscores = [];
  }

  if(!isDefined(player.activities.highscores[varianttag])) {
    player.activities.highscores[varianttag] = 0;
  }
}

function updatescore(scorechange) {
  self.score += scorechange;

  broadcast = function_ab07dddb2e50773b("<dev string:x1c>" + self.score);
  function_2e44f2eaf470e806(broadcast);
}

function function_580d48267e3509af(player) {
  var_f3df5cfd2b12a463 = getscore();
  activityhighscore = getplayerhighscore(player, self.varianttag);

  if(var_f3df5cfd2b12a463 > activityhighscore) {
    player.activities.highscores[self.varianttag] = var_f3df5cfd2b12a463;
    return true;
  }

  return false;
}

function resetscore() {
  self.score = 0;
}

function getscore() {
  return self.score;
}

function getplayerhighscore(player, varianttag) {
  return player.activities.highscores[varianttag];
}

function setscore(score) {
  self.score = score;
}

function broadcastscore(varianttag) {
  iprintln("<dev string:x1c>" + self.score);
}

# /