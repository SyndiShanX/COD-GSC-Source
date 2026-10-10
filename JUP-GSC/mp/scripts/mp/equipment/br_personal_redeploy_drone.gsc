/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\equipment\br_personal_redeploy_drone.gsc
******************************************************************/

#using scripts\common\ae_utility;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\supers;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\player;
#namespace br_personal_redeploy_drone;

function autoexec main() {
  level thread init_when_ready();
}

function init_when_ready() {
  level endon("game_ended");
  level waittill("init_supers");
  init();
}

function init() {
  scripts\mp\supers::function_53110a12409d01da("super_personal_redeploy_drone", undefined, undefined, &function_1798be0772912ae0, undefined, undefined);
  function_f1aed36ab4598ea("eqp_personal_redeploy_drone");
  init_variables();
  init_dev_gui();
}

function init_dev_gui() {
  function_6e7290c8ee4f558b("<dev string:x1c>");
  add_devgui_command("<dev string:x36>", "<dev string:x55>");
  function_fe953f000498048f();
  function_6e7290c8ee4f558b("<dev string:x91>");
  add_devgui_command("<dev string:x36>", "<dev string:xac>");
  function_fe953f000498048f();
}

#using_animtree("script_model");

function initanims() {
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["vm_misc_pers_redeploy_drone_raise"] = % vm_misc_pers_redeploy_drone_raise;
  level.scr_eventanim["player"]["vm_misc_pers_redeploy_drone_raise"] = % "vm_misc_pers_redeploy_drone_raise";
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["vm_misc_pers_redeploy_drone_loop"] = % vm_misc_pers_redeploy_drone_loop;
  level.scr_eventanim["player"]["vm_misc_pers_redeploy_drone_loop"] = % "vm_misc_pers_redeploy_drone_loop";
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["vm_misc_pers_redeploy_drone_loop"] = % vm_misc_pers_redeploy_drone_loop;
  level.scr_eventanim["device"]["vm_misc_pers_redeploy_drone_loop"] = % "vm_misc_pers_redeploy_drone_loop";
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["vm_misc_pers_redeploy_drone_raise"] = % vm_misc_pers_redeploy_drone_raise;
  level.scr_eventanim["device"]["vm_misc_pers_redeploy_drone_raise"] = % "vm_misc_pers_redeploy_drone_raise";
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["iw9_mp_stand_eq_pers_redeploy_drone_raise"] = % iw9_mp_stand_eq_pers_redeploy_drone_raise;
  level.scr_eventanim["device"]["iw9_mp_stand_eq_pers_redeploy_drone_raise"] = % "iw9_mp_stand_eq_pers_redeploy_drone_raise";
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["iw9_mp_eq_pers_redeploy_drone_loop"] = % iw9_mp_eq_pers_redeploy_drone_loop;
  level.scr_eventanim["device"]["iw9_mp_eq_pers_redeploy_drone_loop"] = % "iw9_mp_eq_pers_redeploy_drone_loop";
}

function init_variables() {
  level.var_354cdd3be21c3816 = spawnStruct();
  level.var_354cdd3be21c3816.maxhealth = getdvarint(@ "hash_1a3f3e5d7d85d66", 200);
  level.var_354cdd3be21c3816.heightcheck = getdvarint(@ "hash_6e8ed4dba5669324", 1000);
  level.var_354cdd3be21c3816.heightfly = getdvarint(@ "hash_5a4caf1fb986ed3d", 2200);
  level.var_354cdd3be21c3816.frontcheck = getdvarint(@ "hash_4c317295490ab630", 144);
  level.var_354cdd3be21c3816.flighttime = getdvarfloat(@ "hash_1100bb3b49784382", 2.5);
  level.var_354cdd3be21c3816.var_6fcc6072244f528d = getdvarfloat(@ "hash_214076bbc50622b5", 1);
  level.var_354cdd3be21c3816.var_699e6686ae987b76 = getdvarint(@ "hash_56251ca801089d58", 450);
  level.var_354cdd3be21c3816.maxaltitude = getdvarint(@ "hash_87956834ba2c9da5", 6400);
  level.var_354cdd3be21c3816.var_4f1beac755fcbf5e = level.var_354cdd3be21c3816.flighttime * 0.15;
  level.var_354cdd3be21c3816.var_2d2810a5544c4810 = getdvarint(@ "hash_8ace69b15bc87e78", 350);
  level.var_354cdd3be21c3816.autoparachute = getdvarint(@ "hash_54d723a99cbba03", 0);
  level.var_354cdd3be21c3816.verticalsteer = getdvarint(@ "hash_3844467d573b1434", 34);
  level.var_354cdd3be21c3816.horizontalsteer = getdvarint(@ "hash_a79bd8d12a31c3ee", 34);
  level.var_354cdd3be21c3816.var_764cc4217c118949 = getdvarint(@ "hash_863526b21ddab568", -100);
  level.var_354cdd3be21c3816.var_8cb418e34764e4bd = getdvarint(@ "hash_a98c9ba7e95c38fe", 18);
  level.var_354cdd3be21c3816.var_89e3359918051e8a = getdvarfloat(@ "hash_3516a8526cf93ef", 4);
  level.var_354cdd3be21c3816.momentummultiplier = getdvarfloat(@ "hash_905fb821eddd2d0c", 1.2);
  level.var_354cdd3be21c3816.accelerationtime = getdvarfloat(@ "hash_9451fc5f136786c8", 1);
  level.var_354cdd3be21c3816.var_91a45d7e07124bb3 = getdvarfloat(@ "hash_527a6411c9ece18a", 0.4);
  level.var_354cdd3be21c3816.var_ee0eee91c40741e = getdvarfloat(@ "hash_60ae35c4bb9c1a1d", 1);
  level.var_354cdd3be21c3816.var_cb198b03fcdfe00 = getdvarfloat(@ "hash_ebf0b0e995b5030c", 40);
  initanims();
  game["strings"]["personal_redeploy_drone_insufficient_space"] = &"SUPER_MP/PERSONAL_REDEPLOY_DRONE_INSUFFICENT_SPACE";
  game["strings"]["personal_redeploy_drone_underwater"] = &"SUPER_MP/PERSONAL_REDEPLOY_DRONE_UNDERWATER";
  game["strings"]["prd_prone"] = &"SUPER_MP/PRD_PRONE";
}

function function_1798be0772912ae0() {
  if(function_e339e9564fb310bf()) {
    return false;
  }

  self.super_activated = 1;
  self disableoffhandspecialweapons();
  thread function_7283ccb271e018bf();
  return true;
}

function function_7283ccb271e018bf() {
  if(self isswimming()) {
    self.var_11c539594ebc0fbd = 1;
    self allowmovement(0);
  }

  self skydive_setbasejumpingstatus(0);
  scripts\common\values::set("prd", "killstreaks", 0);
  scripts\common\values::set("prd", "vehicle_use", 0);
  self allowjump(0);
  self allowfire(0);
  self disableoffhandprimaryweapons();
  vehicle_allowplayeruse(self, 0);
  self.original_suit = self.operatorcustomization.suit;
  prdweapon = makeweapon("personal_redeploy_drone_mp_br");
  function_90faf31a7d15329b(1, "hud_icon_minimap_fieldupgrade_personal_redeploy_ally");
  function_90faf31a7d15329b(0, "hud_icon_minimap_fieldupgrade_personal_redeploy_enemy");

  if(self getcamerathirdperson()) {
    scripts\mp\utility\player::_setsuit("iw9_defaultsuit_prd3p_mp");
  } else {
    scripts\mp\utility\player::_setsuit("iw9_defaultsuit_prd_mp");
  }

  waitframe();
  self setstance("stand", 1);
  waitframe();
  allowstances(self, 0);
  thread function_29e6b46ab07b2eff();
  firetime = weaponfiretime("personal_redeploy_drone_mp_br");
  grenadefiretime = weaponfiretime("prd_grenade_mp");
  usetime = firetime + level.var_354cdd3be21c3816.flighttime + grenadefiretime + 0.1;
  setusetime(usetime);
  quickdroptime = self function_a9643e918bdb8032(1);
  quickdroptime *= 0.001;
  wait quickdroptime;
  scripts\cp_mp\utility\weapon_utility::giveandfireoffhandreliable(prdweapon);
  self allowfire(1);
  self enableoffhandprimaryweapons();
  scripts\cp_mp\challenges::function_d997435895422ecc("super_personal_redeploy_drone", ae_utility::function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));
  self disableweaponswitch();
  animtime = function_72df25da8f8ab5ad();
  drone = function_2d7daba228b34e42();
  drone thread function_dc2e55a1917188aa(self);
  waitframe();

  if(!isDefined(drone) || istrue(drone.stopuse)) {
    return;
  }

  if(istrue(self.inlaststand) || function_5e020010d5658ebe(self)) {
    function_3dd876c5ec4242e4(drone);

    if(istrue(self.inlaststand)) {
      val::group_set(self.laststandactionset, 0);
    }

    function_2c67f15bcd9c7f6a(self);
    function_6d77b16d46e949e1(1);
    return;
  }

  self allowjump(1);
  thread function_6646a5b323817f55(drone);
}

function function_e339e9564fb310bf() {
  if(self isswimunderwater()) {
    thread function_e78d15128f9493ec("personal_redeploy_drone_underwater", 1);
    return true;
  }

  if(isDefined(self.triggeringstreak)) {
    return true;
  }

  if(self isvehicleactive() || isDefined(self.vehiclereserved)) {
    return true;
  }

  if(!self isonground() && !self isswimming()) {
    return true;
  }

  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight"]);
  ignorelist = [self];
  var_4e9e1bcc056ccbd9 = self.origin + (0, 0, 63.42);
  castendheight = var_4e9e1bcc056ccbd9 + (0, 0, level.var_354cdd3be21c3816.heightcheck);
  var_c4eda0a2a1b3e725 = 24;
  var_188ecaff115cacb7 = (0, 0, 0);
  halfheight = level.var_354cdd3be21c3816.heightcheck * 0.5 - var_c4eda0a2a1b3e725;
  caststartheight = self.origin + (0, 0, 31.71) + (0, 0, halfheight);
  castendfront = var_4e9e1bcc056ccbd9 + anglesToForward(self getplayerangles(1)) * level.var_354cdd3be21c3816.frontcheck;
  caststartfront = var_4e9e1bcc056ccbd9;
  var_fb76c86e59b95264 = physics_capsulecast(caststartheight, castendheight, var_c4eda0a2a1b3e725, halfheight, var_188ecaff115cacb7, contents, ignorelist, "physicsquery_closest");
  var_64c87b996a465e4a = physics_raycast(caststartfront, castendfront, contents, ignorelist, 0, "physicsquery_closest", 1);

  if(isDefined(var_fb76c86e59b95264) && var_fb76c86e59b95264.size > 0 || isDefined(var_64c87b996a465e4a) && var_64c87b996a465e4a.size > 0) {
    thread function_e78d15128f9493ec("personal_redeploy_drone_insufficient_space", 1);
    return true;
  }

  if(self getstance() == "prone") {
    thread function_e78d15128f9493ec("prd_prone", 1);
    return true;
  }

  return false;
}

function function_e78d15128f9493ec(string, iserror) {
  if(istrue(iserror)) {
    self playlocalsound("eqp_personal_redeploy_drone_error");
  }

  setlowermessageomnvar(string);
  wait 3;
  setlowermessageomnvar("clear_lower_msg");
}

function function_72df25da8f8ab5ad(drone) {
  self endon("death_or_disconnect");

  if(self getcamerathirdperson()) {
    function_1e44eab5a1bd4890(self, 0);
  }

  self attach("misc_vm_pers_redeploy_drone", "tag_accessory_left", 0);
  animtime = self function_cd40fc03fd195d3c();
  animtime *= 0.001;
  notes = getnotetracktimes(%vm_misc_pers_redeploy_drone_raise, "reactor_open");

  if(notes.size > 0) {
    animtime *= notes[0];
  }

  return animtime;
}

function function_b3116874a755bacb(time) {
  wait time;
  self allowfire(1);
  self enableoffhandprimaryweapons();
}

function function_2d7daba228b34e42() {
  spawnorigin = self gettagorigin("tag_accessory");
  drone = spawn("script_model", spawnorigin);
  drone hide();
  drone setModel("misc_vm_pers_redeploy_drone");
  drone.angles = self.angles;
  drone.maxhealth = level.var_354cdd3be21c3816.maxhealth;
  drone.health = drone.maxhealth;
  drone setCanDamage(1);
  drone.player = self;
  drone.skiptoexplosion = 0;
  drone.watchdamage = 1;
  drone thread function_4975171080daff49();
  drone linktoblendtotag(self, "tag_accessory");
  return drone;
}

function function_4975171080daff49() {
  self endon("entitydeleted");

  while(isDefined(self) && self.watchdamage == 1) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    function_84536c668d8bafe3(inflictor, damage, meansofdeath, objweapon);
    waitframe();
  }
}

function function_84536c668d8bafe3(einflictor, damage, smeansofdeath, objweapon) {
  self.health += damage;

  if(objweapon.basename == "prd_grenade_mp") {
    return;
  }

  if(damage < 2) {
    return;
  }

  if(isPlayer(einflictor) && einflictor.team != self.player.team) {
    einflictor scripts\cp_mp\damagefeedback::updatehitmarker("standard", self.health == 0, 0, 1, "hitequip");
  }

  if(!isDefined(einflictor) || einflictor.team != self.player.team) {
    self.health -= damage;
  }

  if(self.health <= 0) {
    self.skiptoexplosion = 1;
    self.watchdamage = 0;
    waitframe();
    self notify("personalRedeployDrone_Stop");
  }
}

function function_6646a5b323817f55(drone) {
  level endon("game_ended");
  drone endon("entitydeleted");
  drone endon("personalRedeployDrone_Stop");
  player = self;
  heightoffset = 1;
  movenode = spawn("script_model", player.origin + (0, 0, heightoffset));
  movenode.angles = player.angles;
  movenode setModel("tag_origin");
  self.movenode = movenode;
  self.var_76c6ee0982ddcdc = 1;

  if(istrue(self.var_11c539594ebc0fbd)) {
    self.var_11c539594ebc0fbd = undefined;
    self allowmovement(1);
  }

  waitframe();
  drone thread function_60f4517c89229b(self);
  function_e4b9fa2e443d43bb(drone, movenode);
}

function function_e4b9fa2e443d43bb(drone, movenode) {
  player = self;
  timeinterval = 0.1;
  totaltimeremaining = level.var_354cdd3be21c3816.flighttime;
  self.var_8c1e2e3b4d920e07 = (0, 0, 0);
  drone.var_ba260ff565e3a14a = 0;
  drone thread function_b94eb4a66fceae77(level.var_354cdd3be21c3816.var_ee0eee91c40741e);
  momentumdistance = (player getvelocity()[0], player getvelocity()[1], 0) * level.var_354cdd3be21c3816.momentummultiplier * level.var_354cdd3be21c3816.flighttime;
  var_56c58548157d7301 = function_289028d1d029beea(player);
  flyheight1 = var_56c58548157d7301 * 0.8;
  var_694fdb0983e994e7 = movenode.origin + (0, 0, flyheight1 - level.var_354cdd3be21c3816.var_764cc4217c118949) + momentumdistance;
  var_42cddca04f38d502 = var_694fdb0983e994e7[2];
  initialz = movenode.origin[2];
  deltaz = abs(var_42cddca04f38d502 - initialz);
  player setOrigin(movenode.origin, 0);
  player playerlinkTo(movenode, "tag_origin", 0, 180, 180, 180, 180, 1);
  waitframe();
  accelerationtime = 0;
  thread function_4d20ccb0d953c558(drone);
  previousplayerorigin = player getorigin();
  player.var_fc13717a229e58bb = 0;

  while(totaltimeremaining >= 0.1) {
    currentgoalz = scripts\engine\math::lerp(deltaz * level.var_354cdd3be21c3816.var_91a45d7e07124bb3, deltaz, accelerationtime / level.var_354cdd3be21c3816.accelerationtime);
    currentgoalz += initialz;
    currentplayerorigin = player getorigin();
    averagevelocity = (currentgoalz - currentplayerorigin[2]) / totaltimeremaining;
    var_561579a6bcea8e90 = averagevelocity * timeinterval;

    if(currentplayerorigin[2] - previousplayerorigin[2] < var_561579a6bcea8e90 * 0.5) {
      player.var_fc13717a229e58bb += 1;

      if(player.var_fc13717a229e58bb > 10) {
        self.var_76c6ee0982ddcdc = 0;
        drone notify("personalRedeployDrone_Stop");
        return;
      }
    } else {
      previousplayerorigin = currentplayerorigin;
      player.var_fc13717a229e58bb = max(player.var_fc13717a229e58bb - 1, 0);
    }

    if(accelerationtime <= level.var_354cdd3be21c3816.accelerationtime) {
      var_694fdb0983e994e7 = (var_694fdb0983e994e7[0], var_694fdb0983e994e7[1], currentgoalz);
      accelerationtime += timeinterval;
    } else {
      var_694fdb0983e994e7 = (var_694fdb0983e994e7[0], var_694fdb0983e994e7[1], var_42cddca04f38d502);
    }

    var_694fdb0983e994e7 = movenode function_d2f06d117f39b7a5(var_694fdb0983e994e7, totaltimeremaining, player);

    if(movenode.origin != var_694fdb0983e994e7 && totaltimeremaining > 0.1) {
      self.var_8c1e2e3b4d920e07 = vectornormalize2(var_694fdb0983e994e7 - movenode.origin);
    }

    if(function_5e020010d5658ebe(player) || player jumpbuttonPressed() && istrue(drone.var_ba260ff565e3a14a)) {
      drone notify("personalRedeployDrone_Stop");
      self.var_76c6ee0982ddcdc = 0;
      return;
    }

    wait timeinterval;
    totaltimeremaining -= timeinterval;
  }

  drone notify("personalRedeployDrone_Stop");
}

function function_b94eb4a66fceae77(time) {
  wait time;

  if(isDefined(self)) {
    self.var_ba260ff565e3a14a = 1;
    self makeusable();
    self setHintString(&"EQUIPMENT_HINTS/PERSONAL_REDEPLOY_DRONE_CANCEL");
    self setCursorHint("HINT_NOICON");
    self setuseholdduration("duration_none");
    self sethintrequiresholding(0);
    self setusecommand("+gostand");
  }
}

function function_d2f06d117f39b7a5(var_694fdb0983e994e7, totaltimeremaining, player) {
  horizontalaxis = player getleftstickx();
  verticalaxis = player getleftsticky();
  deadzone = 0.01;

  if(squared(horizontalaxis) >= deadzone) {
    horizontalsteer = anglestoright(player getplayerangles(1)) * level.var_354cdd3be21c3816.horizontalsteer * horizontalaxis;
    var_694fdb0983e994e7 += horizontalsteer;
  }

  if(squared(verticalaxis) >= deadzone) {
    verticalsteer = anglesToForward(player getplayerangles(1)) * level.var_354cdd3be21c3816.verticalsteer * verticalaxis;
    var_694fdb0983e994e7 += verticalsteer;
  }

  if(isDefined(player.bounce)) {
    player.bounce *= level.var_354cdd3be21c3816.var_cb198b03fcdfe00;
    var_694fdb0983e994e7 = (self.origin[0], self.origin[1], 0) + (player.bounce[0], player.bounce[1], var_694fdb0983e994e7[2]);
    player.bounce = undefined;
  }

  totaltimeremaining = max(totaltimeremaining, 0.01);
  self moveTo(var_694fdb0983e994e7, totaltimeremaining);
  return var_694fdb0983e994e7;
}

function function_3dd876c5ec4242e4(drone) {
  level endon("game_ended");
  player = self;
  skiptoexplosion = 0;

  if(isDefined(drone)) {
    skiptoexplosion = drone.skiptoexplosion;
    drone unlink();
    drone delete();
  }

  if(!isDefined(player)) {
    return;
  }

  function_1e44eab5a1bd4890(player, 1);
  allowstances(player, 1);
  player stopgestureviewmodel("iw9_ges_pers_redeploy_drone");
  player unlink(0);

  if(!player isonground()) {
    player thread function_19a9f4ecc201f1a9(skiptoexplosion);
  }

  animtime = player function_63e76e2a5a785b7d();
  animtime *= 0.001;
  thread function_9f5e1de6c65ab230(player, animtime);
  player function_aa3baee5bf078d29();
  var_837b637cd1457b5e = (0, 0, 0);

  if(isDefined(self.var_8c1e2e3b4d920e07) && lengthsquared(self.var_8c1e2e3b4d920e07) != 0) {
    var_837b637cd1457b5e = self.var_8c1e2e3b4d920e07 * level.var_354cdd3be21c3816.var_2d2810a5544c4810;
  }

  var_699e6686ae987b76 = (0, 0, level.var_354cdd3be21c3816.var_699e6686ae987b76);
  ejectvelocity = var_837b637cd1457b5e + var_699e6686ae987b76;

  if(istrue(self.var_76c6ee0982ddcdc) && !istrue(player.inlaststand) && player.health > 0) {
    player setvelocity(ejectvelocity);
  }

  if(isDefined(self.movenode)) {
    self.movenode delete();
  }

  waitframe();

  if(level.var_354cdd3be21c3816.autoparachute == 1) {
    player skydive_deployparachute();
  }

  player enableweaponswitch();
  player skydive_setbasejumpingstatus(1);
  vehicle_allowplayeruse(player, 1);
  player scripts\common\values::set("prd", "killstreaks", 1);
  player scripts\common\values::set("prd", "vehicle_use", 1);
  player enableoffhandspecialweapons();
}

function function_3829486573c64cef(var_75b6bbe9a2cafb35, waittime) {
  level endon("game_ended");
  wait waittime;
  waitframe();
  self function_a9643e918bdb8032(var_75b6bbe9a2cafb35);
}

function function_4d20ccb0d953c558(drone) {
  level endon("game_ended");
  drone endon("entitydeleted");
  player = self;
  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight"]);
  ignorelist = [drone, player];

  while(player islinked() && isDefined(drone)) {
    if(isDefined(player.bounce)) {
      waitframe();
      continue;
    }

    tag = "tag_accessory";
    radius = 22;
    tagorigin = player gettagorigin(tag);
    start = tagorigin;
    end = tagorigin + (0, 0, radius);
    angles = player gettagangles(tag);
    glassradiusdamage(tagorigin, 100, 10000, 9000);
    results = physics_shapecast(start, end, drone, angles, contents, ignorelist, "physicsquery_closest");

    if(isDefined(results) && results.size > 0) {
      player.bounce = results[0]["contact_normal"];
      waitframe();
    }

    waitframe();
  }
}

function function_1e44eab5a1bd4890(player, lockout) {
  if(isDefined(player)) {
    player allowjump(lockout);
    player allowads(lockout);
    player allowsprint(lockout);
    player allowmelee(lockout);
  }
}

function allowstances(player, lockout) {
  if(isDefined(player)) {
    player allowcrouch(lockout);
    player allowprone(lockout);
  }
}

function function_60f4517c89229b(player) {
  self endon("entitydeleted");
  self endon("personalRedeployDrone_Stop");
  player endon("death_or_disconnect");
  launchvector = (0, 0, 0);

  for(flag = 0; !flag && isDefined(player); flag = 1) {
    prevorigin = player.origin;
    wait 0.05;
    launchvector = (player.origin - prevorigin) * 20;

    if(istrue(player.inlaststand) || isDefined(player.health) && player.health <= 0) {}
  }

  wait 0.05;

  if(isDefined(player)) {
    if(istrue(player.var_11c539594ebc0fbd)) {
      player.var_11c539594ebc0fbd = undefined;
      player allowmovement(1);
    }

    if(!scripts\cp_mp\utility\player_utility::isreallyalive(player)) {
      function_2c67f15bcd9c7f6a(player);
    }

    player allowjump(1);
    player setvelocity(launchvector);
    function_9f5e1de6c65ab230(player, 0);
    player function_aa3baee5bf078d29();
  }

  self notify("personalRedeployDrone_Stop");
}

function function_289028d1d029beea(player) {
  var_72a26ca7a21e14bd = level.var_354cdd3be21c3816.maxaltitude - level.var_354cdd3be21c3816.heightfly;

  if(player.origin[2] > var_72a26ca7a21e14bd) {
    var_22ac6def15391aec = player.origin[2] + level.var_354cdd3be21c3816.heightfly - level.var_354cdd3be21c3816.maxaltitude;
    var_22ac6def15391aec *= 0.5;
    flyheight = level.var_354cdd3be21c3816.heightfly - var_22ac6def15391aec;
    flyheight = max(flyheight, level.var_354cdd3be21c3816.heightfly);
  } else {
    flyheight = level.var_354cdd3be21c3816.heightfly;
  }

  return flyheight;
}

function function_dc2e55a1917188aa(player) {
  thread function_a97e8b060f3de437(player);
}

function function_a97e8b060f3de437(player) {
  self waittill("personalRedeployDrone_Stop");
  self.stopuse = 1;
  player thread function_3dd876c5ec4242e4(self);
}

function function_9f5e1de6c65ab230(player, waittime) {
  wait waittime;

  if(isDefined(player) && isPlayer(player)) {
    player scripts\mp\utility\player::_setsuit(player.original_suit);
    player function_a9643e918bdb8032(0);
  }
}

function setusetime(usetime) {
  if(isDefined(self.super) && isDefined(self.super.staticdata)) {
    self.super.staticdata.usetime = usetime;
  }
}

function function_ebf1c3baec50725a() {
  soundentpos = self gettagorigin("j_wrist_le");
  soundentity = spawn("script_model", soundentpos);
  soundentity linkTo(self, "j_wrist_le");
  self.soundentity = soundentity;
  return soundentity;
}

function function_29e6b46ab07b2eff() {
  soundent = function_ebf1c3baec50725a();
  waitframe();
  soundent playsoundonmovingent("eqp_personal_redeploy_drone_activate");
}

function function_e4420426a0d7adf4(grenade) {
  if(isDefined(self.soundentity) && isDefined(grenade)) {
    self.soundentity linkTo(grenade);
    soundentity = self.soundentity;
    self.soundentity = undefined;
    soundentity playsoundonmovingent("eqp_personal_redeploy_drone_crashing");
    grenade waittill("explode");
    function_b8e3d75435404865(soundentity);
  }
}

function function_19a9f4ecc201f1a9(instantexplode) {
  grenadeweap = makeweapon("prd_grenade_mp");
  self function_9fa79f15382ec4a6(grenadeweap);
  self waittill("grenade_thrown", grenade);
  function_6d77b16d46e949e1(instantexplode);
  grenade thread function_785eff769617c70b(self);
  thread function_e4420426a0d7adf4(grenade);

  if(istrue(instantexplode)) {
    wait 0.2;

    if(isDefined(grenade)) {
      grenade detonate();
    }
  }

  thread function_98b959294d2558cb(1, grenade);
  thread function_98b959294d2558cb(0, grenade);
}

function function_98b959294d2558cb(ally, grenade) {
  var_e1d9b7500ac96007 = undefined;

  if(istrue(ally) && isDefined(self.var_a2558b8e82dce579)) {
    var_e1d9b7500ac96007 = self.var_a2558b8e82dce579;
  } else if(isDefined(self.var_7fba38a831f62d1d)) {
    var_e1d9b7500ac96007 = self.var_7fba38a831f62d1d;
  }

  if(isDefined(var_e1d9b7500ac96007)) {
    if(isDefined(grenade)) {
      objective_onentity(var_e1d9b7500ac96007, grenade);
      grenade waittill("explode");
    }

    scripts\mp\objidpoolmanager::returnobjectiveid(var_e1d9b7500ac96007);
  }
}

function function_90faf31a7d15329b(ally, icon) {
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  objective_state(objid, "active");
  objective_onentity(objid, self);
  function_865f9c5d005f9a08(objid, 1);
  scripts\mp\objidpoolmanager::update_objective_icon(objid, icon);

  if(istrue(ally)) {
    self.var_a2558b8e82dce579 = objid;
    scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(objid, self);
  } else {
    self.var_7fba38a831f62d1d = objid;
    scripts\mp\objidpoolmanager::objective_mask_showtoenemyteam(objid, self);
  }

  objective_sethideelevation(objid, 1);
  objective_setshowdistance(objid, 0);
  objective_setshowoncompass(objid, 0);
  scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
}

function function_aa3baee5bf078d29() {
  if(self tagexists("tag_accessory")) {
    self detach("misc_vm_pers_redeploy_drone", "tag_accessory_left");
  }
}

function function_b8e3d75435404865(soundentity) {
  if(isDefined(soundentity)) {
    soundentity stopsounds();
    waitframe();
    soundentity delete();
  }
}

function function_785eff769617c70b(player) {
  level endon("game_ended");
  self endon("explode");

  if(isDefined(player) && isPlayer(player) && player getcamerathirdperson() && isDefined(self)) {
    self setscriptablepartstate("collision", "none");
    wait 0.1;
    self setscriptablepartstate("collision", "neutral");
  }
}

function function_6d77b16d46e949e1(skiptoexplosion) {
  superinfo = scripts\mp\supers::getcurrentsuper();

  if(isDefined(superinfo) && isDefined(superinfo.staticdata)) {
    scripts\mp\analyticslog::logevent_fieldupgradeexpired(self, superinfo.staticdata.id, undefined, istrue(skiptoexplosion));
  }

  scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
}

function function_2c67f15bcd9c7f6a(player) {
  if(isDefined(player) && isPlayer(player)) {
    if(isDefined(player.var_a2558b8e82dce579)) {
      scripts\mp\objidpoolmanager::returnobjectiveid(player.var_a2558b8e82dce579);
    }

    if(isDefined(player.var_7fba38a831f62d1d)) {
      scripts\mp\objidpoolmanager::returnobjectiveid(player.var_7fba38a831f62d1d);
    }
  }
}

function function_5e020010d5658ebe(player) {
  return player scripts\cp_mp\emp_debuff::is_empd() || istrue(player.ishaywire);
}