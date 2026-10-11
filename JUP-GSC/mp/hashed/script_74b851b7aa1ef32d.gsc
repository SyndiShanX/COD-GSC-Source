/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_74b851b7aa1ef32d.gsc
*************************************************/

#using scripts\mp\rank;
#using scripts\mp\utility\game;
#using scripts\mp\utility\points;
#namespace namespace_40cd4a4db2010f22;

function doonactionscoreevent(eventtype, eventname, cooldown) {
  if(getdvarint(hashcat(@ "scr_", scripts\mp\utility\game::getsubgametype(), "_disable_onactionscoreevents"), 0) == 1) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "br" && !isDefined(level.prematchendtime)) {
    return;
  }

  if(!isDefined(cooldown)) {
    cooldown = 12;
  }

  cooldownms = cooldown * 1000;
  var_b7d39a4661f3460 = gettime();

  if(!isDefined(self.xpcooldowns)) {
    self.xpcooldowns = [];
  }

  if(!isDefined(self.xpcooldowns[eventname])) {
    self.xpcooldowns[eventname] = 0;
  } else if(self.xpcooldowns[eventname] > var_b7d39a4661f3460) {
    return;
  }

  self.xpcooldowns[eventname] = var_b7d39a4661f3460 + cooldownms;

  switch (eventtype) {
    case 0:
      function_a56759f3dec70990(eventname);
      break;
    case 1:
      function_e4278547ad0ee8c8(eventname);
      break;
    case 2:
      function_d25feb1da4499bae(eventname);
      break;
    default:
      break;
  }
}

function function_a56759f3dec70990(eventname) {
  var_c7cba7d0db108110 = getxhash("altScore_equipment_" + eventname);
  function_558e5516ee7925aa(var_c7cba7d0db108110);
}

function function_e4278547ad0ee8c8(eventname) {
  var_c7cba7d0db108110 = getxhash("altScore_fieldUp_" + eventname);
  function_558e5516ee7925aa(var_c7cba7d0db108110);
}

function function_d25feb1da4499bae(eventname) {
  var_c7cba7d0db108110 = getxhash("altScore_killstreak_" + eventname);
  function_558e5516ee7925aa(var_c7cba7d0db108110);
}

function function_558e5516ee7925aa(var_c7cba7d0db108110) {
  points = scripts\mp\rank::getscoreinfovalue(var_c7cba7d0db108110);

  if(isDefined(points)) {
    thread scripts\mp\utility\points::doscoreevent(var_c7cba7d0db108110, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  }
}