/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7cb2174a6df5941f.gsc
***********************************************/

_id_F4AC452FD3842F7C() {
  level._id_9D3D126CF50E30C2 = scripts\engine\utility::getStruct("heli_exfil_point", "script_noteworthy");
  level._id_9D3D126CF50E30C2.origin = getgroundposition(level._id_9D3D126CF50E30C2.origin, 1) + (0, 0, 2);
  return level._id_9D3D126CF50E30C2;
}

_id_F7866C62B996B1E6() {
  _id_99649BC09AE29755();
  initanims();
}

_id_99649BC09AE29755() {
  _id_76DD4BAC487A6057 = (3000, 200, 1200);
  spawndata = spawnStruct();
  spawndata.origin = level._id_9D3D126CF50E30C2.origin + _id_76DD4BAC487A6057;
  spawndata.angles = (0, 0, 0);
  chopper = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_blima", spawndata);
  chopper setCanDamage(0);
  chopper setscriptablepartstate("running_lights", "on", 0);
  chopper setscriptablepartstate("engine", "on", 0);
  chopper setscriptablepartstate("infil_lights", "on", 0);
  chopper.ignoreme = 1;
  chopper thread _id_6785F8B2028CDE91();
  chopper _id_1E9D62F282BAC9D0();
  level._id_9D3D126CF50E30C2.exfilchopper = chopper;
}

_id_1E9D62F282BAC9D0() {
  objid = 0;
  scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", self.origin, "ui_mp_br_mapmenu_icon_vehicle_plunderchopper");
  scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(objid, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(objid);
  scripts\mp\objidpoolmanager::update_objective_onentity(objid, self);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, 90);
}

_id_6785F8B2028CDE91() {
  level endon("game_ended");
  tag = "tag_spotlight";
  self.spotlight = spawnturret("misc_turret", self gettagorigin(tag), "hover_jet_turret_ballistics_mp");
  self.spotlight.angles = self gettagangles(tag);
  self.spotlight setModel("veh9_mil_air_heli_blima_spotlight");
  self.spotlight linkTo(self, tag, (0, 0, 0), (0, 0, 0));
  self.spotlight notsolid();
  self.spotlight makeunusable();
  self.spotlight setmode("manual");
  self.spotlight setdefaultdroppitch(0);
  self.spotlight setleftarc(180);
  self.spotlight setrightarc(180);
  self.spotlight settoparc(180);
  self.spotlight setbottomarc(180);
  self.spotlight setconvergencetime(0.05, "yaw");
  self.spotlight setconvergencetime(0.05, "pitch");
  self.spotlight.targetent = level._id_9D3D126CF50E30C2 scripts\engine\utility::spawn_tag_origin();
  self.spotlight settargetentity(self.spotlight.targetent);
  self.spotlight forcenetfieldhighlod(1);
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_dmz_bio_lab_heli_spotlight"), self.spotlight, "tag_flash");
}

_id_DC126CDC32901F99(players) {
  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0.1);
    player _meth_B88C89BB7CD1AB8E(level._id_9D3D126CF50E30C2.origin);
    player scripts\mp\utility\player::hidehudenable();
    player setcinematicmotionoverride("disabled");
    player setclientomnvar("ui_br_squad_eliminated_active", 0);

    if(isDefined(player.sessionstate)) {
      if(player.sessionstate == "intermission")
        player scripts\mp\utility\player::updatesessionstate("spectator");

      if(player.sessionstate == "spectator") {
        player setspectatedefaults(level._id_9D3D126CF50E30C2.cam.origin, level._id_9D3D126CF50E30C2.cam.angles);
        player spawn(level._id_9D3D126CF50E30C2.cam.origin, level._id_9D3D126CF50E30C2.cam.angles);
        continue;
      }

      player setOrigin(level._id_9D3D126CF50E30C2.origin + (0, 0, 100));
    }
  }
}

_id_F5478303DCCFCE0D(players) {
  level._id_9D3D126CF50E30C2.cam = level._id_9D3D126CF50E30C2 create_cam();
  rope = level._id_9D3D126CF50E30C2 _id_40F4C8F2B94C5CD9::spawn_script_model("equipment_fast_rope_wm_01_infil_heli_l", "rope");
  ascenders = [];

  foreach(index, player in players)
  ascenders[index] = level._id_9D3D126CF50E30C2 _id_40F4C8F2B94C5CD9::spawn_script_model("misc_wm_ascender", "ascender" + index);

  level._id_9D3D126CF50E30C2.animents = [];
  level._id_9D3D126CF50E30C2.animents["blima_exfil"] = [];

  foreach(ascender in ascenders)
  level._id_9D3D126CF50E30C2.animents["blima_exfil"][level._id_9D3D126CF50E30C2.animents["blima_exfil"].size] = ascender;

  level._id_9D3D126CF50E30C2.animents["blima_exfil"][level._id_9D3D126CF50E30C2.animents["blima_exfil"].size] = rope;
  scripts\common\anim::addnotetrack_customfunction("ascender0", "delete_me", ::_id_C8491B4D010A599B);
  scripts\common\anim::addnotetrack_customfunction("ascender1", "delete_me", ::_id_C8491A4D010A5768);
  scripts\common\anim::addnotetrack_customfunction("ascender2", "delete_me", ::_id_C8491D4D010A5E01);
  scripts\common\anim::addnotetrack_customfunction("ascender3", "delete_me", ::_id_6C0504CC87F70F90);
}

#using_animtree("script_model");

initanims() {
  level.scr_animtree["rope"] = #animtree;
  level.scr_anim["rope"]["blima_exfil"] = % br_exfil_rope_sh020;
  level.scr_animname["rope"]["blima_exfil"] = "br_exfil_rope_sh020";
  level.scr_animtree["ascender0"] = #animtree;
  level.scr_anim["ascender0"]["blima_exfil"] = % br_exfil_ascender0_sh020;
  level.scr_animname["ascender0"]["blima_exfil"] = "br_exfil_ascender0_sh020";
  level.scr_animtree["ascender1"] = #animtree;
  level.scr_anim["ascender1"]["blima_exfil"] = % br_exfil_ascender1_sh020;
  level.scr_animname["ascender1"]["blima_exfil"] = "br_exfil_ascender1_sh020";
  level.scr_animtree["ascender2"] = #animtree;
  level.scr_anim["ascender2"]["blima_exfil"] = % br_exfil_ascender2_sh020;
  level.scr_animname["ascender2"]["blima_exfil"] = "br_exfil_ascender2_sh020";
  level.scr_animtree["ascender3"] = #animtree;
  level.scr_anim["ascender3"]["blima_exfil"] = % br_exfil_ascender3_sh020;
  level.scr_animname["ascender3"]["blima_exfil"] = "br_exfil_ascender3_sh020";
  level.scr_animtree["player0"] = #animtree;
  level.scr_anim["player0"]["blima_exfil"] = % br_exfil_guy0_sh020;
  level.scr_animname["player0"]["blima_exfil"] = "br_exfil_guy0_sh020";
  level.scr_eventanim["player0"]["blima_exfil"] = "br_exfil_guy0_sh020";
  level.scr_animtree["player1"] = #animtree;
  level.scr_anim["player1"]["blima_exfil"] = % br_exfil_guy1_sh020;
  level.scr_animname["player1"]["blima_exfil"] = "br_exfil_guy1_sh020";
  level.scr_eventanim["player1"]["blima_exfil"] = "br_exfil_guy1_sh020";
  level.scr_animtree["player2"] = #animtree;
  level.scr_anim["player2"]["blima_exfil"] = % br_exfil_guy2_sh020;
  level.scr_animname["player2"]["blima_exfil"] = "br_exfil_guy2_sh020";
  level.scr_eventanim["player2"]["blima_exfil"] = "br_exfil_guy2_sh020";
  level.scr_animtree["player3"] = #animtree;
  level.scr_anim["player3"]["blima_exfil"] = % br_exfil_guy3_sh020;
  level.scr_animname["player3"]["blima_exfil"] = "br_exfil_guy3_sh020";
  level.scr_eventanim["player3"]["blima_exfil"] = "br_exfil_guy3_sh020";
  level.scr_animtree["cam"] = #animtree;
  level.scr_anim["cam"]["blima_exfil"] = % iw9_dmz_biolab_exfil_cam;
  level.scr_animname["cam"]["blima_exfil"] = "iw9_dmz_biolab_exfil_cam";
}

_id_373DA23F1E6C21AB(_id_246AEE6688CC8EAE) {
  _id_4AE750A933C6A8BD = (0, 0, 900);
  _id_D4CF75E8A617D80C = level._id_9D3D126CF50E30C2.origin + _id_4AE750A933C6A8BD;
  dist = distance(level._id_9D3D126CF50E30C2.exfilchopper.origin, _id_D4CF75E8A617D80C);
  speed = scripts\engine\utility::ips_to_mph(dist / _id_246AEE6688CC8EAE);
  level._id_9D3D126CF50E30C2.exfilchopper sethoverparams(25, 15, 10);
  level._id_9D3D126CF50E30C2.exfilchopper vehicle_setspeed(speed, 10, 10);
  level._id_9D3D126CF50E30C2.exfilchopper setvehgoalpos(_id_D4CF75E8A617D80C, 1);
  level._id_9D3D126CF50E30C2.exfilchopper waittill("goal");
}

_id_131F077855A5C35B() {
  _id_4AE750A933C6A8BD = (3000, 200, 1200);
  level._id_9D3D126CF50E30C2.exfilchopper setvehgoalpos(level._id_9D3D126CF50E30C2.origin + _id_4AE750A933C6A8BD, 1);
  level._id_9D3D126CF50E30C2.exfilchopper waittill("goal");
}

_id_231E512D244410AD(players) {
  level notify("dmz_biolab_heli_exfil_start");
  _id_DC126CDC32901F99(players);

  if(players.size > 4)
    players = scripts\engine\utility::array_slice(players, 0, 4);

  level._id_9D3D126CF50E30C2.players = players;
  _id_A5DE001203E83374();
  _id_40F4C8F2B94C5CD9::allplayers_setfov(45);
  _id_F5478303DCCFCE0D(players);
  _id_2D9C29F869A29FCA::_id_3140165E8671CD37();
  _id_30BE9C2148BDCF86();
  level._id_289DF80E1DED586F = 0;
  wait 1;
  _id_974783060E6F28B7();
  _id_CEF94D01782A121C();
}

_id_974783060E6F28B7() {
  level _id_0DDA586D27C1CEBE::_id_3528D4AECC341AAE();
  _id_61A98BB74B5F2D94 = spawn("script_model", level._id_9D3D126CF50E30C2.origin);
  _id_61A98BB74B5F2D94 setModel("iw9_biolabs_helicopter_exfil_gas_fx");
  _id_61A98BB74B5F2D94 forcenetfieldhighlod(1);
  _id_61A98BB74B5F2D94 setscriptablepartstate("fx", "on", 0);
  level._id_9D3D126CF50E30C2._id_0C39D1928B5C5D36 = _id_61A98BB74B5F2D94;
}

_id_CEF94D01782A121C() {
  level._id_9D3D126CF50E30C2 scripts\common\anim::anim_first_frame_solo(level._id_9D3D126CF50E30C2.cam, "blima_exfil");

  foreach(player in level._id_9D3D126CF50E30C2.players) {
    player cameralinkTo(level._id_9D3D126CF50E30C2.cam, "tag_player", 1, 1);
    player dontinterpolate();
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 0.1);
  }

  foreach(player in level._id_9D3D126CF50E30C2.players)
  level._id_9D3D126CF50E30C2 thread scripts\mp\anim::anim_player_solo(player, player.player_rig, "blima_exfil");

  foreach(ent in level._id_9D3D126CF50E30C2.animents["blima_exfil"])
  ent dontinterpolate();

  level._id_9D3D126CF50E30C2 thread scripts\common\anim::anim_single(level._id_9D3D126CF50E30C2.animents["blima_exfil"], "blima_exfil");
  level._id_9D3D126CF50E30C2.cam dontinterpolate();
  level._id_9D3D126CF50E30C2 scripts\common\anim::anim_single_solo(level._id_9D3D126CF50E30C2.cam, "blima_exfil");
}

_id_A5DE001203E83374() {
  foreach(index, player in level._id_9D3D126CF50E30C2.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(isDefined(player.sessionstate) && player.sessionstate != "playing") {
      player.forcespawnorigin = (0, 0, 0);
      player scripts\mp\playerlogic::spawnplayer(0);
    }

    player _id_5C6B989A6F25F7FA::player_abilities_disable();
    player _id_5C6B989A6F25F7FA::player_equipment_use_stop();
    player.plotarmor = 1;
    player.oobimmunity = 1;
    player.ignoreme = 1;
    player _id_5C6B989A6F25F7FA::player_set_weapon();
    player scripts\mp\utility\player::setwind("60", 1);
    player _id_40F4C8F2B94C5CD9::create_player_rig("player" + index, "viewhands_base_iw8", level._id_9D3D126CF50E30C2);
  }
}

_id_30BE9C2148BDCF86() {
  foreach(player in level.players) {
    if(isalive(player)) {
      if(!scripts\engine\utility::array_contains(level._id_9D3D126CF50E30C2.players, player))
        player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
    }
  }
}

create_cam() {
  model = spawn("script_model", self.origin);
  model setModel("tag_origin");
  model forcenetfieldhighlod(1);
  model useanimtree(#animtree);
  model.animname = "cam";
  return model;
}

cleanup() {
  _id_40F4C8F2B94C5CD9::_id_CF47AB3F9DEFE35B();

  if(isDefined(level._id_9D3D126CF50E30C2.animents)) {
    foreach(_id_1D2BE7531AAF82AF in level._id_9D3D126CF50E30C2.animents) {
      foreach(ent in _id_1D2BE7531AAF82AF) {
        if(isDefined(ent))
          ent delete();
      }
    }
  }

  if(isDefined(level._id_9D3D126CF50E30C2._id_0C39D1928B5C5D36))
    level._id_9D3D126CF50E30C2._id_0C39D1928B5C5D36 delete();

  if(isDefined(level._id_9D3D126CF50E30C2.cam))
    level._id_9D3D126CF50E30C2.cam delete();

  if(isDefined(level._id_9D3D126CF50E30C2.exfilchopper))
    level._id_9D3D126CF50E30C2.exfilchopper delete();

  foreach(player in level._id_9D3D126CF50E30C2.players) {
    if(isDefined(player) && isDefined(player.player_rig)) {
      if(isDefined(player.sessionstate) && player.sessionstate == "spectator")
        player setspectatedefaults(level._id_9D3D126CF50E30C2.origin, level._id_9D3D126CF50E30C2.angles);
      else
        player setOrigin(level._id_9D3D126CF50E30C2.origin);

      player.player_rig delete();
    }
  }
}

_id_C8491B4D010A599B(ent) {
  if(level._id_9D3D126CF50E30C2.players.size == 1)
    _id_6C0504CC87F70F90();
}

_id_C8491A4D010A5768(ent) {
  if(level._id_9D3D126CF50E30C2.players.size == 2)
    _id_6C0504CC87F70F90();
}

_id_C8491D4D010A5E01(ent) {
  if(level._id_9D3D126CF50E30C2.players.size == 3)
    _id_6C0504CC87F70F90();
}

_id_6C0504CC87F70F90() {
  level._id_9D3D126CF50E30C2.cam notify("single anim", "end");
}