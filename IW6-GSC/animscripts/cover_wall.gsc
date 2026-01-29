/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\cover_wall.gsc
**************************************/

#using_animtree("generic_human");

init_animset_cover_wall() {
  var_0 = [];
  var_0["add_aim_up"] = % covercrouch_aim8_add;
  var_0["add_aim_down"] = % covercrouch_aim2_add;
  var_0["add_aim_left"] = % covercrouch_aim4_add;
  var_0["add_aim_right"] = % covercrouch_aim6_add;
  var_0["straight_level"] = % covercrouch_aim5;
  var_0["hide_idle"] = % covercrouch_hide_idle;
  var_0["hide_idle_twitch"] = animscripts\utility::array(%covercrouch_twitch_1, %covercrouch_twitch_2, %covercrouch_twitch_3, %covercrouch_twitch_4);
  var_0["hide_idle_flinch"] = animscripts\utility::array();
  var_0["hide_2_crouch"] = % covercrouch_hide_2_aim;
  var_0["hide_2_stand"] = % covercrouch_hide_2_stand;
  var_0["hide_2_lean"] = % covercrouch_hide_2_lean;
  var_0["hide_2_right"] = % covercrouch_hide_2_right;
  var_0["hide_2_left"] = % covercrouch_hide_2_left;
  var_0["crouch_2_hide"] = % covercrouch_aim_2_hide;
  var_0["stand_2_hide"] = % covercrouch_stand_2_hide;
  var_0["lean_2_hide"] = % covercrouch_lean_2_hide;
  var_0["right_2_hide"] = % covercrouch_right_2_hide;
  var_0["left_2_hide"] = % covercrouch_left_2_hide;
  var_0["crouch_aim"] = % covercrouch_aim5;
  var_0["stand_aim"] = % exposed_aim_5;
  var_0["lean_aim"] = % covercrouch_lean_aim5;
  var_0["fire"] = % exposed_shoot_auto_v2;
  var_0["semi2"] = % exposed_shoot_semi2;
  var_0["semi3"] = % exposed_shoot_semi3;
  var_0["semi4"] = % exposed_shoot_semi4;
  var_0["semi5"] = % exposed_shoot_semi5;
  var_0["single"] = [%exposed_shoot_semi1];
  var_0["burst2"] = % exposed_shoot_burst3;
  var_0["burst3"] = % exposed_shoot_burst3;
  var_0["burst4"] = % exposed_shoot_burst4;
  var_0["burst5"] = % exposed_shoot_burst5;
  var_0["burst6"] = % exposed_shoot_burst6;
  var_0["blind_fire"] = animscripts\utility::array(%covercrouch_blindfire_1, %covercrouch_blindfire_2, %covercrouch_blindfire_3, %covercrouch_blindfire_4);
  var_0["reload"] = % covercrouch_reload_hide;
  var_0["grenade_safe"] = animscripts\utility::array(%covercrouch_grenadea, %covercrouch_grenadeb);
  var_0["grenade_exposed"] = animscripts\utility::array(%covercrouch_grenadea, %covercrouch_grenadeb);
  var_0["exposed_idle"] = animscripts\utility::array(%exposed_idle_alert_v1, %exposed_idle_alert_v2, %exposed_idle_alert_v3);
  var_0["look"] = animscripts\utility::array(%covercrouch_hide_look);
  anim.archetypes["soldier"]["cover_crouch"] = var_0;
  var_0 = [];
  var_0["add_aim_up"] = % coverstandaim_aim8_add;
  var_0["add_aim_down"] = % coverstandaim_aim2_add;
  var_0["add_aim_left"] = % coverstandaim_aim4_add;
  var_0["add_aim_right"] = % coverstandaim_aim6_add;
  var_0["straight_level"] = % coverstandaim_aim5;
  var_0["hide_idle"] = % coverstand_hide_idle;
  var_0["hide_idle_twitch"] = animscripts\utility::array(%coverstand_hide_idle_twitch01, %coverstand_hide_idle_twitch02, %coverstand_hide_idle_twitch03, %coverstand_hide_idle_twitch04, %coverstand_hide_idle_twitch05);
  var_0["hide_idle_flinch"] = animscripts\utility::array(%coverstand_react01, %coverstand_react02, %coverstand_react03, %coverstand_react04);
  var_0["hide_2_stand"] = % coverstand_hide_2_aim;
  var_0["stand_2_hide"] = % coverstand_aim_2_hide;
  var_0["hide_2_over"] = % coverstand_2_coverstandaim;
  var_0["over_2_hide"] = % coverstandaim_2_coverstand;
  var_0["over_aim"] = % coverstandaim_aim5;
  var_0["fire"] = % coverstandaim_autofire;
  var_0["semi2"] = % coverstandaim_fire;
  var_0["semi3"] = % coverstandaim_fire;
  var_0["semi4"] = % coverstandaim_fire;
  var_0["semi5"] = % coverstandaim_fire;
  var_0["single"] = animscripts\utility::array(%coverstandaim_fire);
  var_0["burst2"] = % coverstandaim_autofire;
  var_0["burst3"] = % coverstandaim_autofire;
  var_0["burst4"] = % coverstandaim_autofire;
  var_0["burst5"] = % coverstandaim_autofire;
  var_0["burst6"] = % coverstandaim_autofire;
  var_0["blind_fire"] = animscripts\utility::array(%coverstand_blindfire_1, %coverstand_blindfire_2);
  var_0["reload"] = % coverstand_reloada;
  var_0["look"] = animscripts\utility::array(%coverstand_look_quick, %coverstand_look_quick_v2);
  var_0["grenade_safe"] = animscripts\utility::array(%coverstand_grenadea, %coverstand_grenadeb);
  var_0["grenade_exposed"] = animscripts\utility::array(%coverstand_grenadea, %coverstand_grenadeb);
  var_0["exposed_idle"] = animscripts\utility::array(%exposed_idle_alert_v1, %exposed_idle_alert_v2, %exposed_idle_alert_v3);
  var_0["hide_to_look"] = % coverstand_look_moveup;
  var_0["look_idle"] = % coverstand_look_idle;
  var_0["look_to_hide"] = % coverstand_look_movedown;
  var_0["look_to_hide_fast"] = % coverstand_look_movedown_fast;
  anim.archetypes["soldier"]["cover_stand"] = var_0;
}

cover_wall_think(var_0) {
  self endon("killanimscript");
  self.covernode = self.node;
  self.covertype = var_0;

  if(!isDefined(self.node.turret))
    animscripts\cover_behavior::turntomatchnodedirection(0);

  if(var_0 == "crouch") {
    setup_cover_crouch("unknown");
    self.covernode initcovercrouchnode();
  } else
    setup_cover_stand("unknown");

  self.a.aimidlethread = undefined;
  self orientmode("face angle", self.covernode.angles[1]);

  if(isDefined(self.weapon) && animscripts\utility::usingmg() && isDefined(self.node) && isDefined(self.node.turretinfo) && canspawnturret()) {
    if(var_0 == "crouch") {
      if(isrpd(self.weapon))
        var_1 = "rpd_bipod_crouch";
      else
        var_1 = "saw_bipod_crouch";
    } else if(isrpd(self.weapon))
      var_1 = "rpd_bipod_stand";
    else
      var_1 = "saw_bipod_stand";

    if(isrpd(self.weapon))
      var_2 = "weapon_rpd_MG_Setup";
    else
      var_2 = "weapon_saw_MG_Setup";

    useselfplacedturret(var_1, var_2);
  } else if(isDefined(self.node) && isDefined(self.node.turret))
    usestationaryturret();

  self animmode("normal");

  if(var_0 == "crouch" && self.a.pose == "stand") {
    var_3 = animscripts\utility::animarray("stand_2_hide");
    var_4 = getanimlength(var_3);
    self setanimknoballrestart(var_3, %body, 1, 0.2, animscripts\combat_utility::fasteranimspeed());
    thread animscripts\shared::movetonodeovertime(self.covernode, var_4);
    wait(var_4);
    self.a.covermode = "hide";
  } else {
    loophide(0.4);

    if(distancesquared(self.origin, self.covernode.origin) > 1) {
      thread animscripts\shared::movetonodeovertime(self.covernode, 0.4);
      wait 0.2;

      if(var_0 == "crouch")
        self.a.pose = "crouch";

      wait 0.2;
    } else
      wait 0.1;
  }

  setdefaultwallanimmode();

  if(var_0 == "crouch") {
    if(self.a.pose == "prone")
      animscripts\utility::exitpronewrapper(1);

    self.a.pose = "crouch";
  }

  if(self.covertype == "stand")
    self.a.special = "cover_stand";
  else
    self.a.special = "cover_crouch";

  var_5 = spawnStruct();

  if(!self.fixednode)
    var_5.movetonearbycover = animscripts\cover_behavior::movetonearbycover;

  var_5.reload = ::coverreload;
  var_5.leavecoverandshoot = ::popupandshoot;
  var_5.look = ::look;
  var_5.fastlook = ::fastlook;
  var_5.idle = ::idle;
  var_5.flinch = ::flinch;
  var_5.grenade = ::trythrowinggrenade;
  var_5.grenadehidden = ::trythrowinggrenadestayhidden;
  var_5.blindfire = ::blindfire;
  animscripts\cover_behavior::main(var_5);
}

isrpd(var_0) {
  return getsubstr(var_0, 0, 3) == "rpd" && (var_0.size == 3 || var_0[3] == "_");
}

initcovercrouchnode() {
  if(isDefined(self.crouchingisok)) {
    return;
  }
  var_0 = (0, 0, 42);
  var_1 = anglesToForward(self.angles);
  self.crouchingisok = sighttracepassed(self.origin + var_0, self.origin + var_0 + var_1 * 64, 0, undefined);
}

setup_cover_crouch(var_0) {
  animscripts\combat::set_default_aim_limits(self.covernode);
  setup_crouching_anim_array(var_0);
}

setup_cover_stand(var_0) {
  animscripts\combat::set_default_aim_limits(self.covernode);
  setup_standing_anim_array(var_0);
}

coverreload() {
  var_0 = animscripts\combat_utility::reload(2.0, animscripts\utility::animarray("reload"));

  if(isDefined(var_0) && var_0)
    return 1;

  return 0;
}

popupandshoot() {
  self.keepclaimednodeifvalid = 1;

  if(isDefined(self.rambochance) && randomfloat(1) < self.rambochance) {
    if(rambo())
      return 1;
  }

  if(!pop_up())
    return 0;

  shootastold();
  animscripts\combat_utility::endfireandanimidlethread();

  if(isDefined(self.shootpos)) {
    var_0 = lengthsquared(self.origin - self.shootpos);

    if(animscripts\utility::usingrocketlauncher() && animscripts\utility::shoulddroprocketlauncher(var_0)) {
      if(self.a.pose == "stand")
        animscripts\shared::throwdownweapon(animscripts\utility::lookupanim("combat", "drop_rpg_stand"));
      else
        animscripts\shared::throwdownweapon(animscripts\utility::lookupanim("combat", "drop_rpg_crouch"));
    }
  }

  go_to_hide();
  self.covercrouchlean_aimmode = undefined;
  self.keepclaimednodeifvalid = 0;
  return 1;
}

shootastold() {
  self endon("return_to_cover");
  maps\_gameskill::didsomethingotherthanshooting();

  for(;;) {
    if(isDefined(self.shouldreturntocover)) {
      break;
    }

    if(!isDefined(self.shootpos)) {
      self waittill("do_slow_things");
      waittillframeend;

      if(isDefined(self.shootpos)) {
        continue;
      }
      break;
    }

    if(!self.bulletsinclip) {
      break;
    }

    if(self.covertype == "crouch" && needtochangecovermode()) {
      break;
    }

    shootuntilshootbehaviorchange_coverwall();
    self clearanim(%add_fire, 0.2);
  }
}

shootuntilshootbehaviorchange_coverwall() {
  if(self.covertype == "crouch")
    thread anglerangethread();

  thread animscripts\combat_utility::aimidlethread();
  animscripts\combat_utility::shootuntilshootbehaviorchange();
}

rambo() {
  if(!animscripts\utility::hasenemysightpos())
    return 0;

  var_0 = "rambo";

  if(randomint(10) < 2)
    var_0 = "rambo_fail";

  if(!animscripts\utility::animarrayanyexist(var_0))
    return 0;

  if(self.covertype == "crouch" && !self.covernode.crouchingisok)
    return 0;

  var_1 = getshootpospitch(self.covernode.origin + animscripts\utility::getnodeoffset(self.covernode));

  if(var_1 > 15)
    return 0;

  var_2 = anglesToForward(self.angles);
  var_3 = self.origin + var_2 * -16;

  if(!self maymovetopoint(var_3))
    return 0;

  self.coverposestablishedtime = gettime();
  setdefaultwallanimmode();
  self.keepclaimednodeifvalid = 1;
  self.isrambo = 1;
  self.a.prevattack = "rambo";
  self.changingcoverpos = 1;
  thread animscripts\shared::ramboaim(0);
  var_4 = animscripts\utility::animarraypickrandom(var_0);
  self setflaggedanimknoballrestart("rambo", var_4, %body, 1, 0.2, 1);
  cover_playfacialanim(var_4);
  animscripts\shared::donotetracks("rambo");
  self notify("rambo_aim_end");
  self.changingcoverpos = 0;
  self.keepclaimednodeifvalid = 0;
  self.lastrambotime = gettime();
  self.changingcoverpos = 0;
  self.isrambo = undefined;
  return 1;
}

idle() {
  self endon("end_idle");

  for(;;) {
    var_0 = randomint(2) == 0 && animscripts\utility::animarrayanyexist("hide_idle_twitch");

    if(var_0)
      var_1 = animscripts\utility::animarraypickrandom("hide_idle_twitch");
    else
      var_1 = animscripts\utility::animarray("hide_idle");

    playidleanimation(var_1, var_0);
  }
}

flinch() {
  if(!animscripts\utility::animarrayanyexist("hide_idle_flinch"))
    return 0;

  var_0 = anglesToForward(self.angles);
  var_1 = self.origin + var_0 * -16;

  if(!self maymovetopoint(var_1, !self.swimmer))
    return 0;

  setdefaultwallanimmode();
  self.keepclaimednodeifvalid = 1;
  var_2 = animscripts\utility::animarraypickrandom("hide_idle_flinch");
  playidleanimation(var_2, 1);
  self.keepclaimednodeifvalid = 0;
  return 1;
}

playidleanimation(var_0, var_1) {
  if(var_1)
    self setflaggedanimknoballrestart("idle", var_0, %body, 1, 0.25, 1);
  else
    self setflaggedanimknoball("idle", var_0, %body, 1, 0.25, 1);

  cover_playfacialanim(var_0);
  self.a.covermode = "hide";
  animscripts\shared::donotetracks("idle");
}

look(var_0) {
  if(!isDefined(self.a.array["hide_to_look"]))
    return 0;

  if(!peekout())
    return 0;

  animscripts\shared::playlookanimation(animscripts\utility::animarray("look_idle"), var_0);
  var_1 = undefined;

  if(animscripts\utility::issuppressedwrapper())
    var_1 = animscripts\utility::animarray("look_to_hide_fast");
  else
    var_1 = animscripts\utility::animarray("look_to_hide");

  self setflaggedanimknoballrestart("looking_end", var_1, %body, 1, 0.1);
  cover_playfacialanim(var_1);
  animscripts\shared::donotetracks("looking_end");
  return 1;
}

peekout() {
  if(isDefined(self.covernode.script_dontpeek))
    return 0;

  var_0 = animscripts\utility::animarray("hide_to_look");
  self setflaggedanimknoball("looking_start", var_0, %body, 1, 0.2);
  cover_playfacialanim(var_0);
  animscripts\shared::donotetracks("looking_start");
  return 1;
}

fastlook() {
  var_0 = animscripts\utility::animarraypickrandom("look");
  self setflaggedanimknoballrestart("look", var_0, %body, 1, 0.1);
  cover_playfacialanim(var_0);
  animscripts\shared::donotetracks("look");
  return 1;
}

pop_up_and_hide_speed() {
  if(self.a.covermode == "left" || self.a.covermode == "right" || self.a.covermode == "over")
    return 1;

  return animscripts\combat_utility::randomfasteranimspeed();
}

pop_up() {
  var_0 = getbestcovermode();
  var_1 = 0.1;
  var_2 = animscripts\utility::animarray("hide_2_" + var_0);
  var_3 = !self.swimmer;

  if(!self maymovetopoint(animscripts\utility::getanimendpos(var_2), var_3))
    return 0;

  if(self.script == "cover_crouch" && var_0 == "lean")
    self.covercrouchlean_aimmode = 1;

  if(self.covertype == "crouch")
    setup_cover_crouch(var_0);
  else
    setup_cover_stand(var_0);

  self.a.special = "none";
  self.specialdeathfunc = undefined;

  if(self.covertype == "stand")
    self.a.special = "cover_stand_aim";
  else
    self.a.special = "cover_crouch_aim";

  self.changingcoverpos = 1;
  self notify("done_changing_cover_pos");
  setdefaultwallanimmode();
  var_4 = pop_up_and_hide_speed();
  self setflaggedanimknoballrestart("pop_up", var_2, %body, 1, 0.1, var_4);
  thread donotetracksforpopup("pop_up");

  if(animhasnotetrack(var_2, "start_aim")) {
    self waittillmatch("pop_up", "start_aim");
    var_1 = getanimlength(var_2) / var_4 * (1 - self getanimtime(var_2));
  } else {
    self waittillmatch("pop_up", "end");
    var_1 = 0.1;
  }

  self clearanim(var_2, var_1 + 0.05);
  self.a.covermode = var_0;
  self.a.prevattack = var_0;
  setup_additive_aim(var_1);
  thread animscripts\track::trackshootentorpos();
  wait(var_1);

  if(animscripts\combat_utility::issniper())
    thread animscripts\shoot_behavior::sniper_glint_behavior();

  self.changingcoverpos = 0;
  self.coverposestablishedtime = gettime();
  self notify("stop_popup_donotetracks");
  return 1;
}

donotetracksforpopup(var_0) {
  self endon("killanimscript");
  self endon("stop_popup_donotetracks");
  animscripts\shared::donotetracks(var_0);
}

setup_additive_aim(var_0) {
  if(self.a.covermode == "left" || self.a.covermode == "right")
    var_1 = "crouch";
  else
    var_1 = self.a.covermode;

  self setanimknoball(animscripts\utility::animarray(var_1 + "_aim"), %body, 1, var_0);

  if(var_1 == "crouch") {
    self setanimlimited(animscripts\utility::lookupanim("cover_crouch", "add_aim_down"), 1, 0);
    self setanimlimited(animscripts\utility::lookupanim("cover_crouch", "add_aim_left"), 1, 0);
    self setanimlimited(animscripts\utility::lookupanim("cover_crouch", "add_aim_up"), 1, 0);
    self setanimlimited(animscripts\utility::lookupanim("cover_crouch", "add_aim_right"), 1, 0);
  } else if(var_1 == "stand") {
    self setanimlimited(animscripts\utility::lookupanim("default_stand", "add_aim_down"), 1, 0);
    self setanimlimited(animscripts\utility::lookupanim("default_stand", "add_aim_left"), 1, 0);
    self setanimlimited(animscripts\utility::lookupanim("default_stand", "add_aim_up"), 1, 0);
    self setanimlimited(animscripts\utility::lookupanim("default_stand", "add_aim_right"), 1, 0);
  } else if(var_1 == "lean") {
    self setanimlimited(animscripts\utility::lookupanim("default_stand", "add_aim_down"), 1, 0);
    self setanimlimited(animscripts\utility::lookupanim("default_stand", "add_aim_left"), 1, 0);
    self setanimlimited(animscripts\utility::lookupanim("default_stand", "add_aim_up"), 1, 0);
    self setanimlimited(animscripts\utility::lookupanim("default_stand", "add_aim_right"), 1, 0);
  } else if(var_1 == "over") {
    self setanimlimited(animscripts\utility::lookupanim("cover_stand", "add_aim_down"), 1, 0);
    self setanimlimited(animscripts\utility::lookupanim("cover_stand", "add_aim_left"), 1, 0);
    self setanimlimited(animscripts\utility::lookupanim("cover_stand", "add_aim_up"), 1, 0);
    self setanimlimited(animscripts\utility::lookupanim("cover_stand", "add_aim_right"), 1, 0);
  }
}

go_to_hide() {
  self notify("return_to_cover");
  self.changingcoverpos = 1;
  self notify("done_changing_cover_pos");
  animscripts\combat_utility::endaimidlethread();
  var_0 = pop_up_and_hide_speed();
  self setflaggedanimknoball("go_to_hide", animscripts\utility::animarray(self.a.covermode + "_2_hide"), %body, 1, 0.2, var_0);
  self clearanim(%exposed_modern, 0.2);
  animscripts\shared::donotetracks("go_to_hide");
  self.a.covermode = "hide";

  if(self.covertype == "stand")
    self.a.special = "cover_stand";
  else
    self.a.special = "cover_crouch";

  self.changingcoverpos = 0;
}

trythrowinggrenadestayhidden(var_0) {
  return trythrowinggrenade(var_0, 1);
}

trythrowinggrenade(var_0, var_1) {
  if(isDefined(self.dontevershoot) || isDefined(var_0.dontattackme))
    return 0;

  var_2 = undefined;

  if(isDefined(self.rambochance) && randomfloat(1.0) < self.rambochance)
    var_2 = animscripts\utility::animarraypickrandom("grenade_rambo");
  else if(isDefined(var_1) && var_1)
    var_2 = animscripts\utility::animarraypickrandom("grenade_safe");
  else
    var_2 = animscripts\utility::animarraypickrandom("grenade_exposed");

  setdefaultwallanimmode();
  self.keepclaimednodeifvalid = 1;
  var_3 = animscripts\combat_utility::trygrenade(var_0, var_2);
  self.keepclaimednodeifvalid = 0;
  return var_3;
}

blindfire() {
  if(!animscripts\utility::animarrayanyexist("blind_fire"))
    return 0;

  setdefaultwallanimmode();
  self.keepclaimednodeifvalid = 1;
  self setflaggedanimknoballrestart("blindfire", animscripts\utility::animarraypickrandom("blind_fire"), %body, 1, 0.2, 1);
  animscripts\shared::donotetracks("blindfire");
  self.keepclaimednodeifvalid = 0;
  return 1;
}

createturret(var_0, var_1, var_2) {
  var_3 = spawnturret("misc_turret", var_0.origin, var_1);
  var_3.angles = var_0.angles;
  var_3.aiowner = self;
  var_3 setModel(var_2);
  var_3 makeusable();
  var_3 setdefaultdroppitch(0);

  if(isDefined(var_0.leftarc))
    var_3.leftarc = var_0.leftarc;

  if(isDefined(var_0.rightarc))
    var_3.rightarc = var_0.rightarc;

  if(isDefined(var_0.toparc))
    var_3.toparc = var_0.toparc;

  if(isDefined(var_0.bottomarc))
    var_3.bottomarc = var_0.bottomarc;

  return var_3;
}

deleteifnotused(var_0) {
  self endon("death");
  self endon("being_used");
  wait 0.1;

  if(isDefined(var_0))
    var_0 notify("turret_use_failed");

  self delete();
}

useselfplacedturret(var_0, var_1) {
  var_2 = createturret(self.node.turretinfo, var_0, var_1);

  if(self useturret(var_2)) {
    var_2 thread deleteifnotused(self);

    if(isDefined(self.turret_function))
      thread[[self.turret_function]](var_2);

    self waittill("turret_use_failed");
  } else
    var_2 delete();
}

usestationaryturret() {
  var_0 = self.node.turret;

  if(!var_0.issetup) {
    return;
  }
  thread maps\_mg_penetration::gunner_think(var_0);
  self waittill("continue_cover_script");
}

setup_crouching_anim_array(var_0) {
  self.a.array = animscripts\utility::lookupanimarray("cover_crouch");

  if(animscripts\utility::weapon_pump_action_shotgun()) {
    if(var_0 == "lean" || var_0 == "stand")
      self.a.array["single"] = animscripts\utility::lookupanim("shotgun_stand", "single");
    else
      self.a.array["single"] = animscripts\utility::lookupanim("shotgun_crouch", "single");
  }

  if(isDefined(anim.ramboanims)) {
    self.a.array["rambo"] = anim.ramboanims.covercrouch;
    self.a.array["rambo_fail"] = anim.ramboanims.covercrouchfail;
    self.a.array["grenade_rambo"] = anim.ramboanims.covercrouchgrenade;
  }
}

setup_standing_anim_array(var_0) {
  self.a.array = animscripts\utility::lookupanimarray("cover_stand");

  if(var_0 != "over") {
    var_1 = animscripts\utility::lookupanimarray("default_stand");
    self.a.array["stand_aim"] = var_1["straight_level"];
    self.a.array["fire"] = var_1["fire_corner"];
    self.a.array["semi2"] = var_1["semi2"];
    self.a.array["semi3"] = var_1["semi3"];
    self.a.array["semi4"] = var_1["semi4"];
    self.a.array["semi5"] = var_1["semi5"];

    if(animscripts\utility::weapon_pump_action_shotgun())
      self.a.array["single"] = animscripts\utility::lookupanim("shotgun_stand", "single");
    else
      self.a.array["single"] = var_1["single"];

    self.a.array["burst2"] = var_1["burst2"];
    self.a.array["burst3"] = var_1["burst3"];
    self.a.array["burst4"] = var_1["burst4"];
    self.a.array["burst5"] = var_1["burst5"];
    self.a.array["burst6"] = var_1["burst6"];
  }

  if(isDefined(anim.ramboanims)) {
    self.a.array["rambo"] = anim.ramboanims.coverstand;
    self.a.array["rambo_fail"] = anim.ramboanims.coverstandfail;
    self.a.array["grenade_rambo"] = anim.ramboanims.coverstandgrenade;
  }
}

loophide(var_0) {
  if(!isDefined(var_0))
    var_0 = 0.1;

  self setanimknoballrestart(animscripts\utility::animarray("hide_idle"), %body, 1, var_0);
  self.a.covermode = "hide";
}

anglerangethread() {
  self endon("killanimscript");
  self notify("newAngleRangeCheck");
  self endon("newAngleRangeCheck");
  self endon("return_to_cover");

  for(;;) {
    if(needtochangecovermode()) {
      break;
    }

    wait 0.1;
  }

  self notify("stopShooting");
}

needtochangecovermode() {
  if(self.covertype != "crouch")
    return 0;

  var_0 = getshootpospitch(self getEye());

  if(self.a.covermode == "lean")
    return var_0 < 10;
  else
    return var_0 > 45;
}

getbestcovermode() {
  var_0 = [];

  if(self.covertype == "stand") {
    var_0 = self.covernode getvalidcoverpeekouts();
    var_0[var_0.size] = "stand";
  } else {
    var_1 = getshootpospitch(self.covernode.origin + animscripts\utility::getnodeoffset(self.covernode));

    if(var_1 > 30)
      return "lean";

    if(var_1 > 15 || !self.covernode.crouchingisok)
      return "stand";

    var_0 = self.covernode getvalidcoverpeekouts();
    var_0[var_0.size] = "crouch";
  }

  var_2 = 0;

  while(var_2 < var_0.size) {
    if(!isDefined(self.a.array["hide_2_" + var_0[var_2]])) {
      var_0[var_2] = var_0[var_0.size - 1];
      var_0[var_0.size - 1] = undefined;
      continue;
    }

    var_2++;
  }

  return animscripts\combat_utility::getrandomcovermode(var_0);
}

getshootpospitch(var_0) {
  var_1 = animscripts\utility::getenemyeyepos();
  return angleclamp180(vectortoangles(var_1 - var_0)[0]);
}

setdefaultwallanimmode() {
  if(self.swimmer)
    self animmode("nogravity");
  else
    self animmode("zonly_physics");
}

cover_playfacialanim(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "run";

  self.facialidx = animscripts\face::playfacialanim(var_0, var_1, self.facialidx);
}

cover_clearfacialanim() {
  self.facialidx = undefined;
  self clearanim(%head, 0.2);
}