/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\_agent_common.gsc
****************************************************/

_id_003D() {
  maps\mp\agents\_agent_utility::_id_5291();
  var_0 = "axis";

  if(level._id_687D % 2 == 0)
    var_0 = "allies";

  level._id_687D++;
  maps\mp\agents\_agent_utility::hudoutlineenable(var_0);
  level._id_0A4E[level._id_0A4E.size] = self;
}

_id_003E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_1 = maps\mp\_utility::_id_073C(var_1);
  self[[maps\mp\agents\_agent_utility::_id_0A59("on_damaged")]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

_id_003F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_1 = maps\mp\_utility::_id_073C(var_1);
  maps\mp\agents\_agent_utility::cleanupentsonagentdeath();
  self thread[[maps\mp\agents\_agent_utility::_id_0A59("on_killed")]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

init() {
  _id_5290();
  level thread _id_08F8();
}

_id_2581(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    var_0._id_2589 = gettime();

    if(isDefined(var_2))
      var_0 maps\mp\agents\_agent_utility::hudoutlineenable(var_2);
    else
      var_0 maps\mp\agents\_agent_utility::hudoutlineenable(var_0.team);

    if(isDefined(var_3))
      var_0._id_231C = var_3;

    if(isDefined(self.target))
      var_0._id_90AA = self.target;

    if(isDefined(level._id_0A41[var_1]) && isDefined(level._id_0A41[var_1]["onAIConnect"]))
      var_0[[var_0 maps\mp\agents\_agent_utility::_id_0A59("onAIConnect")]]();

    _addtocharactersarray(var_0);
  }

  return var_0;
}

_id_2586(var_0, var_1, var_2) {
  var_3 = maps\mp\agents\_agent_utility::_id_44EE(var_0);
  return _id_2581(var_3, var_0, var_1, var_2);
}

_id_2588(var_0, var_1, var_2, var_3) {
  maps\mp\agents\_agent_utility::_id_5344(var_0, var_1);
  return _id_2581(var_0, var_1, var_2, var_3);
}

_id_5290() {
  level._id_0A4E = [];
  level._id_687D = 0;
}

_id_08F8() {
  level endon("game_ended");
  level waittill("connected", var_0);
  var_1 = maps\mp\agents\_agent_utility::get_max_agents();

  while(level._id_0A4E.size < var_1) {
    var_2 = _addagent();

    if(!isDefined(var_2)) {
      waitframe();
      continue;
    }
  }
}

_id_83FD(var_0) {
  self._id_0008 = var_0;
  self.health = var_0;
  self.maxhealth = var_0;
}