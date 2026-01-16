/***************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\cover_multi.gsc
***************************************/

main() {
  if(!isdefined(self.cover))
    self.cover = spawnstruct();

  self.cover.state = "none";
  self.cover.laststatechangetime = 0;
  self.cover.istatechange = 0;
  self.cover.hidestate = covermulti_choosehidestate();
  self.covernode = self.node;
  covermulti_think();
  self waittill("killanimscript");
}

end_script() {
  covermulti_exitstate(self.cover.state);
  self.cover.fnoverlord = undefined;
  self.cover.laststatechangetime = undefined;
  self.cover.istatechange = undefined;
  animscripts\corner::end_script_corner();
  animscripts\cover_behavior::end_script("multi");
}

covermulti_think() {
  if(!isdefined(self.covernode)) {
    return;
  }
  var_0 = self.covernode getvalidcoverpeekouts();

  if(isdefined(self.cover.arrivalnodetype)) {
    if(covermulti_isvaliddir(self.cover.arrivalnodetype, var_0)) {
      var_1 = covermulti_setdir(self.cover.arrivalnodetype);
      self.cover.arrivalnodetype = undefined;
      return;
    }
  }

  if(!isdefined(self.enemy)) {
    covermulti_setdir(covermulti_getrandomvaliddir(var_0));
    return;
  }

  var_2 = self.covernode.origin;
  var_3 = self.enemy.origin;
  var_4 = var_3 - var_2;
  var_5 = vectortoangles(var_4);
  var_6 = angleclamp180(var_5[1] - self.covernode.angles[1]);
  var_7 = undefined;

  if(var_6 > 12)
    var_8 = ["left", "over", "right"];
  else if(var_6 < -12)
    var_8 = ["right", "over", "left"];
  else if(var_6 > 5) {
    var_8 = [
      ["left", "over"], "right"
    ];
    var_7 = 15000;
  } else if(var_6 < -5) {
    var_8 = [
      ["right", "over"], "left"
    ];
    var_7 = 15000;
  } else {
    var_8 = ["over", ["right", "left"]];
    var_7 = 15000;
  }

  var_9 = covermulti_getbestvaliddir(var_8, var_0);
  var_1 = covermulti_setdir(var_9, var_7);
}

covermulti_isvaliddir(var_0, var_1) {
  if(!isdefined(var_1))
    var_1 = self.node getvalidcoverpeekouts();

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == var_0)
      return 1;
  }

  return 0;
}

covermulti_getbestvaliddir(var_0, var_1) {
  if(!isdefined(var_1))
    var_1 = self.node getvalidcoverpeekouts();

  var_2 = [];

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(!isarray(var_4)) {
      var_2[var_2.size] = var_4;
      continue;
    }

    var_4 = common_scripts\utility::array_randomize(var_4);

    for (var_5 = 0; var_5 < var_4.size; var_5++)
      var_2[var_2.size] = var_4[var_5];
  }

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    if(covermulti_isvaliddir(var_2[var_3], var_1))
      return var_2[var_3];
  }
}

covermulti_getrandomvaliddir(var_0) {
  if(!isdefined(var_0))
    var_0 = self.node getvalidcoverpeekouts();

  var_1 = randomint(var_0.size);
  return var_0[var_1];
}

covermulti_getnonrandomvaliddir(var_0) {
  if(!isdefined(var_0))
    var_0 = self getvalidcoverpeekouts();

  if(var_0[0] == "over") {
    if(self doesnodeallowstance("stand"))
      return "stand";
    else
      return "crouch";
  }

  return var_0[0];
}

covermulti_setdir(var_0, var_1) {
  if(var_0 == "over") {
    var_2 = self.node doesnodeallowstance("stand");
    var_3 = self.node doesnodeallowstance("crouch");

    if(var_2) {
      if(self.cover.state != "crouch" || !var_3)
        covermulti_setstate("stand", var_1);

      return 1;
    } else if(var_3) {
      if(self.cover.state != "stand" || !var_2)
        covermulti_setstate("crouch", var_1);

      return 1;
    } else {

    }
  } else {
    covermulti_setstate(var_0, var_1);
    return 1;
  }

  return 0;
}

covermulti_setstate(var_0, var_1) {
  if(self.cover.state == var_0)
    return 0;

  if(!isdefined(var_1) || var_1 < 0)
    var_1 = 8000;

  var_2 = gettime();

  if(self.cover.laststatechangetime > 0 && var_2 - self.cover.laststatechangetime < var_1)
    return 0;

  self.cover.laststatechangetime = var_2;
  thread covermulti_setstateinternal(var_0);
  return 1;
}

covermulti_setstateinternal(var_0) {
  var_1 = covermulti_choosehidestate();
  covermulti_dotransition(self.cover.state, self.a.pose, self.cover.hidestate, var_0, self.a.pose, var_1);
  covermulti_exitstate(self.cover.state);
  self.cover.state = var_0;
  self.cover.hidestate = var_1;
  covermulti_enterstate(self.cover.state);
}

covermulti_enterstate(var_0) {
  if(var_0 == "left")
    animscripts\cover_left::main();
  else if(var_0 == "right")
    animscripts\cover_right::main();
  else if(var_0 == "stand")
    animscripts\cover_stand::main();
  else if(var_0 == "crouch")
    animscripts\cover_crouch::main();
  else {}
}

covermulti_exitstate(var_0) {
  switch (var_0) {
    case "left":
      animscripts\cover_left::end_script();
      break;
    case "right":
      animscripts\cover_right::end_script();
      break;
    case "stand":
      animscripts\cover_stand::end_script();
      break;
    case "crouch":
      animscripts\cover_crouch::end_script();
      break;
  }
}

#using_animtree("generic_human");

covermulti_dotransition(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("killanimscript");

  if(var_0 == "none" || var_3 == "none") {
    return;
  }
  var_6 = covermulti_getanimtransition(var_0, var_1, var_2, var_3, var_4, var_5);

  if(!isdefined(var_6)) {
    return;
  }
  self setflaggedanimknoball("cover_multi_trans", var_6, % body, 1, 0.2, 1);
  animscripts\shared::donotetracks("cover_multi_trans");
}

covermulti_choosehidestate() {
  if(!isdefined(self.a.array) || !isdefined(self.a.array["alert_idle_back"]))
    return "forward";

  if(common_scripts\utility::cointoss())
    return "forward";
  else
    return "back";
}

covermulti_getstatefromdir(var_0, var_1) {
  if(var_1 == "left" || var_1 == "right")
    return var_1;

  if(var_0 doesnodeallowstance("stand"))
    return "stand";

  return "crouch";
}

covermulti_getanimtransition(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_2 == "back")
    var_6 = var_1 + "_back";
  else if(var_0 == "stand" || var_0 == "crouch")
    var_6 = var_0 + "_forward";
  else
    var_6 = var_0 + "_" + var_1;

  var_6 = var_6 + "_to_";

  if(var_5 == "back")
    var_6 = var_6 + (var_4 + "_back");
  else if(var_3 == "stand" || var_3 == "crouch")
    var_6 = var_6 + (var_3 + "_forward");
  else
    var_6 = var_6 + (var_3 + "_" + var_4);

  var_7 = self.animarchetype;

  if(!isdefined(var_7) || !isdefined(anim.archetypes[var_7]["cover_multi"]))
    var_7 = "soldier";

  return anim.archetypes[var_7]["cover_multi"][var_6];
}

init_animset_cover_multi() {
  var_0 = [];
  var_0["stand"] = [];
  var_0["stand"]["trans"] = [];
  var_0["stand"]["trans"]["left_stand"] = [];
  var_0["stand"]["trans"]["left_crouch"] = [];
  var_0["stand"]["trans"]["right_stand"] = [];
  var_0["stand"]["trans"]["right_crouch"] = [];
  var_0["stand"]["trans"]["front_stand"] = [];
  var_0["stand"]["trans"]["front_crouch"] = [];
  var_0["stand"]["trans"]["back_stand"] = [];
  var_0["stand"]["trans"]["back_crouch"] = [];
  var_0["left_stand_to_right_stand"] = undefined;
  var_0["left_stand_to_right_crouch"] = undefined;
  var_0["left_stand_to_stand_back"] = undefined;
  var_0["left_stand_to_stand_forward"] = undefined;
  var_0["left_stand_to_crouch_back"] = undefined;
  var_0["left_stand_to_crouch_forward"] = undefined;
  var_0["left_crouch_to_right_stand"] = undefined;
  var_0["left_crouch_to_right_crouch"] = undefined;
  var_0["left_crouch_to_stand_back"] = undefined;
  var_0["left_crouch_to_stand_forward"] = undefined;
  var_0["left_crouch_to_crouch_back"] = undefined;
  var_0["left_crouch_to_crouch_forward"] = undefined;
  var_0["crouch"] = [];
  anim.archetypes["soldier"]["cover_multi"] = var_0;
}