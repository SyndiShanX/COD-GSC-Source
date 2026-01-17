/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_utility.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_weapons;
#namespace zm_utility;

function ignore_triggers(timer) {
  self endon("death");
  self.ignoretriggers = 1;
  if(isDefined(timer)) {
    wait(timer);
  } else {
    wait(0.5);
  }
  self.ignoretriggers = 0;
}

function is_encounter() {
  return false;
}

function round_up_to_ten(score) {
  new_score = score - (score % 10);
  if(new_score < score) {
    new_score = new_score + 10;
  }
  return new_score;
}

function round_up_score(score, value) {
  score = int(score);
  new_score = score - (score % value);
  if(new_score < score) {
    new_score = new_score + value;
  }
  return new_score;
}

function halve_score(n_score) {
  n_score = n_score / 2;
  n_score = round_up_score(n_score, 10);
  return n_score;
}

function spawn_weapon_model(localclientnum, weapon, model = weapon.worldmodel, origin, angles, options) {
  weapon_model = spawn(localclientnum, origin, "script_model");
  if(isDefined(angles)) {
    weapon_model.angles = angles;
  }
  if(isDefined(options)) {
    weapon_model useweaponmodel(weapon, model, options);
  } else {
    weapon_model useweaponmodel(weapon, model);
  }
  return weapon_model;
}

function spawn_buildkit_weapon_model(localclientnum, weapon, camo, origin, angles) {
  weapon_model = spawn(localclientnum, origin, "script_model");
  if(isDefined(angles)) {
    weapon_model.angles = angles;
  }
  weapon_model usebuildkitweaponmodel(localclientnum, weapon, camo, zm_weapons::is_weapon_upgraded(weapon));
  return weapon_model;
}

function is_classic() {
  return true;
}

function is_gametype_active(a_gametypes) {
  b_is_gametype_active = 0;
  if(!isarray(a_gametypes)) {
    a_gametypes = array(a_gametypes);
  }
  for(i = 0; i < a_gametypes.size; i++) {
    if(getdvarstring("g_gametype") == a_gametypes[i]) {
      b_is_gametype_active = 1;
    }
  }
  return b_is_gametype_active;
}

function setinventoryuimodels(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isspectating(localclientnum)) {
    return;
  }
  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "zmInventory." + fieldname), newval);
}

function setsharedinventoryuimodels(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "zmInventory." + fieldname), newval);
}

function zm_ui_infotext(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "zmInventory.infoText"), fieldname);
  } else {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "zmInventory.infoText"), "");
  }
}

function drawcylinder(pos, rad, height, color) {
  currad = rad;
  curheight = height;
  debugstar(pos, 1, color);
  for(r = 0; r < 20; r++) {
    theta = (r / 20) * 360;
    theta2 = ((r + 1) / 20) * 360;
    line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0), color, 1, 1, 100);
    line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight), color, 1, 1, 100);
    line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight), color, 1, 1, 100);
  }
}

function umbra_fix_logic(localclientnum) {
  self endon("disconnect");
  self endon("entityshutdown");
  umbra_settometrigger(localclientnum, "");
  while(true) {
    in_fix_area = 0;
    if(isDefined(level.custom_umbra_hotfix)) {
      in_fix_area = self thread[[level.custom_umbra_hotfix]](localclientnum);
    }
    if(in_fix_area == 0) {
      umbra_settometrigger(localclientnum, "");
    }
    wait(0.05);
  }
}

function umbra_fix_trigger(localclientnum, pos, height, radius, umbra_name) {
  bottomy = pos[2];
  topy = pos[2] + height;
  if(self.origin[2] > bottomy && self.origin[2] < topy) {
    if(distance2dsquared(self.origin, pos) < (radius * radius)) {
      umbra_settometrigger(localclientnum, umbra_name);
      drawcylinder(pos, radius, height, (0, 1, 0));
      return true;
    }
  }
  drawcylinder(pos, radius, height, (1, 0, 0));
  return false;
}