/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_hostage.gsc
***********************************************/

init_hostages(var_0, var_1) {
  if(!scripts\engine\utility::flag_exist("_encstr_92EB192703D27CB8B5CF36E8358BA0BF6ABF87A193FACCA8CD22BB"))
    scripts\engine\utility::flag_init("_encstr_92EB192703D27CB8B5CF36E8358BA0BF6ABF87A193FACCA8CD22BB");

  if(istrue(var_0))
    level.hostages_disablelookat = 1;

  if(istrue(var_1))
    level.hostages_disablesounds = 1;
}

setup_hostage_anims(var_0, var_1) {
  set_building_hostage_id(var_0);
  var_2 = randomintrange(1, 5);
  var_3 = "_encstr_91BE0F34DEDCD1B07659AFA519D8CABE06" + var_2;
  var_4 = "_encstr_88E112A1B0F3EB0FD83530E007C1CB53533DDE48" + var_2;
  thread anim_hostage_idle(var_3, var_0);
  thread anim_hostage_wait_release(var_4);
}

make_hostage_usable(var_0, var_1) {
  civ_init(self);
  self.onuse = ::civ_hostage;
  self.trigger = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin + (-1, 0, 35));
  self.trigger linkTo(self, "_encstr_A1190BD4FABB9396DC47EB8DAC");
  self.trigger.group_name = var_0.group_name;
  self.trigger.hostage = self;
  self.trigger makeusable();
  self.trigger setuseprioritymax();
  self.trigger setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  self.trigger sethintdisplayrange(148);
  self.trigger sethintdisplayfov(90);
  self.trigger setuserange(72);
  self.trigger setusefov(45);
  self.trigger sethintonobstruction("_encstr_BD1805CB69C063");
  self.trigger sethintrequiresholding(1);
  self.trigger setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  thread scripts\engine\utility::delete_on_death(self.trigger);
  thread ai_used_think();

  if(!isDefined(level.hostages_spawned_triggers))
    level.hostages_spawned_triggers = [];

  level.hostages_spawned_triggers[level.hostages_spawned_triggers.size] = self.trigger;
  level thread set_flag_spawned();
}

set_flag_spawned() {
  wait 1;
  scripts\engine\utility::flag_set("_encstr_92EB192703D27CB8B5CF36E8358BA0BF6ABF87A193FACCA8CD22BB");
}

despawn_hostage(var_0) {
  self notify("_encstr_96F40E2EEC1FD34971EA9820C3963728");
  self endon("_encstr_96F40E2EEC1FD34971EA9820C3963728");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = var_0 * var_0;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(self.origin, var_1)) {
      wait 2;
      continue;
    }

    break;
  }

  hostage_kill();
}

hostage_kill() {
  if(isDefined(self.trigger)) {
    var_0 = scripts\engine\utility::array_find(level.hostages_spawned_triggers, self.trigger);
    level.hostages_spawned_triggers = scripts\engine\utility::array_remove_index(level.hostages_spawned_triggers, var_0);

    if(isent(self.trigger))
      self.trigger delete();
  }

  self kill();
}

allow_despawn_all_hostages() {
  foreach(var_1 in level.spawned_hostage_modules) {
    foreach(var_3 in var_1.ai_spawned) {
      if(isalive(var_3))
        var_3 thread despawn_hostage(5000);

      wait 0.05;
    }
  }
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

anim_init_hostage() {
  if(isDefined(level.scr_animtree["_encstr_99B5105ED35823FF70A6724A09DABBDE8877"])) {
    return;
  }
  level.scr_animtree["_encstr_99B5105ED35823FF70A6724A09DABBDE8877"] = #animtree;
  level.scr_anim["_encstr_99B5105ED35823FF70A6724A09DABBDE8877"]["_encstr_BA8E0766EA368EDE9B"] = % _encstr_828726D883AF99571B3ADE73AF43DEB947C2D956FA9567B0D8AF46B2B35A1BACF5BBF6AEE6469519;
  level.scr_animname["_encstr_99B5105ED35823FF70A6724A09DABBDE8877"]["_encstr_BA8E0766EA368EDE9B"] = "_encstr_828726D883AF99571B3ADE73AF43DEB947C2D956FA9567B0D8AF46B2B35A1BACF5BBF6AEE6469519";
  level.scr_animtree["_encstr_8B880DFAA82963324D26E91BF7D72A"] = #animtree;
  level.scr_anim["_encstr_8B880DFAA82963324D26E91BF7D72A"]["_encstr_BA8E0766EA368EDE9B"] = % _encstr_AB9625F0870709AD04E4DF8851694833E19389A007ADA576530F88926818DD09508A8355A94BFA;
  level.scr_animname["_encstr_8B880DFAA82963324D26E91BF7D72A"]["_encstr_BA8E0766EA368EDE9B"] = "_encstr_AB9625F0870709AD04E4DF8851694833E19389A007ADA576530F88926818DD09508A8355A94BFA";
  level.scr_animtree["_encstr_8BB007E03658CBCAE4"] = #animtree;
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_BA8E0766EA368EDE9B"] = % _encstr_8BE226FF4BCE8167996D5F10572A45EF839677FB18F94CF2E92FE8E0E3BB88DAD9605565CD233A9D;
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_BA8E0766EA368EDE9B"] = "_encstr_BA8E0766EA368EDE9B";
  level.scr_animtree["_encstr_8E1C0FB675401B1D1D41325A3871D61FD9"] = #animtree;
  level.scr_anim["_encstr_8E1C0FB675401B1D1D41325A3871D61FD9"]["_encstr_BA8E0766EA368EDE9B"] = % _encstr_84782320FB67F9DBEA3BA820D98227839457F898DFF5B3AB62E996BB6B292F48FDD3682B9B;
  level.scr_animname["_encstr_8E1C0FB675401B1D1D41325A3871D61FD9"]["_encstr_BA8E0766EA368EDE9B"] = "_encstr_84782320FB67F9DBEA3BA820D98227839457F898DFF5B3AB62E996BB6B292F48FDD3682B9B";
}

create_vip_fulton_trigger(var_0, var_1) {
  var_2 = var_0.angles;

  if(isDefined(var_1))
    var_2 = var_2 + var_1;

  var_0.trigger = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_3 = rotatevector((0, 0, 15.5), var_0.angles);
  var_0.trigger linkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_3, (0, 0, 0));
  var_0.trigger makeusable();
  var_0.trigger setHintString(&"_encstr_96CA2A0FB9A009BBD5EAC22982D155989DC9F33929464369B7E3A45BCD93E80E7C81AD7FB0A61FFFA76A4CD4");
  var_0.trigger setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_0.trigger sethintdisplayrange(256);
  var_0.trigger sethintdisplayfov(360);
  var_0.trigger setuserange(72);
  var_0.trigger setusefov(80);
  var_0.trigger sethintonobstruction("_encstr_BD1805CB69C063");
  var_0.trigger sethintrequiresholding(1);
  var_0.trigger setuseholdduration("_encstr_BA7610B09BFEB998E2F778C98342BC771BDD");
  var_0 thread scripts\engine\utility::delete_on_death(var_0.trigger);
  var_0 thread vip_use_fulton_think(var_0);
}

_id_142BB(var_0) {
  var_0.linktoent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_0.linktoent.angles = var_0.angles;
  var_0 linkTo(var_0.linktoent);
}

vip_use_fulton_think(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.trigger endon("_encstr_AD75063D571AE108");
  var_0.trigger thread vip_use_fulton_start();

  for(;;) {
    var_0.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    var_0 notify("_encstr_8E1C0FB675401B1D1D41325A3871D61FD9", var_2);
    level notify("_encstr_8E1C0FB675401B1D1D41325A3871D61FD9", var_2, var_0, var_0.openaltbunker);

    if(isDefined(var_0.linktoent)) {
      var_0 unlink();
      var_0.linktoent delete();
    }

    var_0.trigger makeunusable();
  }
}

vip_use_fulton_start() {
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_93461143DEC7CA1FF04AD13A3A32EF6A5F700B", var_0);
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_BD1E13BD4CD4F5C82B9D5A6C95F5E695E8E8A5373B", undefined, 0.6);
}

anim_fulton_hostage_player_scene(var_0, var_1, var_2) {
  var_3 = undefined;
  self waittill("_encstr_8E1C0FB675401B1D1D41325A3871D61FD9", var_3);

  if(isDefined(var_3) && var_3 scripts\cp_mp\utility\player_utility::_isalive())
    var_3.ability_invulnerable = 1;

  if(isagent(var_0)) {
    return;
  }
  var_4 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4.origin);
  var_5.angles = var_4.angles;
  var_5 setModel("_encstr_A28C1C9BDA5D9D9D362B397DA5DC33B727B5C237D1FACCD5D8C698DBC8E5");
  var_5.animname = "_encstr_8E1C0FB675401B1D1D41325A3871D61FD9";
  var_5 useanimtree(level.scr_animtree["_encstr_8E1C0FB675401B1D1D41325A3871D61FD9"]);
  var_5 dontinterpolate();
  var_5 hide();

  if(isDefined(var_1)) {
    var_1.origin = var_5 gettagorigin("_encstr_BDAB07BA596A43E9EB");
    var_1 linkTo(var_5, "_encstr_BDAB07BA596A43E9EB");
  }

  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4.origin);
  var_6 setModel("_encstr_BEDF1A22D8C15FE308ED6947C77068E3F8B0DA89C12F3F1C58336B4B");
  var_6.angles = var_4.angles;
  var_6.animname = "_encstr_99B5105ED35823FF70A6724A09DABBDE8877";
  var_6 useanimtree(level.scr_animtree["_encstr_99B5105ED35823FF70A6724A09DABBDE8877"]);
  var_6 dontinterpolate();
  var_6 hide();
  level thread chopper_can_see(var_5);
  waitframe();
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4.origin);
  var_7 setModel("_encstr_A93F176B4B634BE8859CE5D737B5971AB7F66DFA43C2A3C6A1");
  var_7.angles = var_4.angles;
  var_7.animname = "_encstr_99B5105ED35823FF70A6724A09DABBDE8877";
  var_7 useanimtree(level.scr_animtree["_encstr_99B5105ED35823FF70A6724A09DABBDE8877"]);
  var_7 linkTo(var_6, "_encstr_B2D212FAB6E9E73C18CF1BE14DF0C7D786E9E3B2", (0, 2, -10), (0, 20, 90));
  var_7 dontinterpolate();
  var_7 hide();
  waitframe();
  var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4.origin);
  var_8 setModel("_encstr_A6541BDA5A8D4BE80B4EF27DE66DBC43EDF65BBE0EB0270B6C34AB3A56");
  var_8.angles = var_4.angles;
  var_8.animname = "_encstr_99B5105ED35823FF70A6724A09DABBDE8877";
  var_8 useanimtree(level.scr_animtree["_encstr_99B5105ED35823FF70A6724A09DABBDE8877"]);
  var_8 hide();
  waitframe();
  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4.origin - (0, 0, 10000));
  var_9 setModel("_encstr_A2631FB45A529979FFC38AD1A78BCB79A143F14846614917EFB297A957CD16E34D");
  var_9.angles = var_4.angles;
  var_9.animname = "_encstr_8B880DFAA82963324D26E91BF7D72A";
  var_9 useanimtree(level.scr_animtree["_encstr_8B880DFAA82963324D26E91BF7D72A"]);
  var_10 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_3, "_encstr_8BB007E03658CBCAE4", 1, 0, 1);
  var_11 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_6, "_encstr_99B5105ED35823FF70A6724A09DABBDE8877");
  var_11 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  var_12 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_8, "_encstr_99B5105ED35823FF70A6724A09DABBDE8877");
  var_12 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  var_13 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_9, "_encstr_8B880DFAA82963324D26E91BF7D72A");
  var_13 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  var_14 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_5, "_encstr_8E1C0FB675401B1D1D41325A3871D61FD9");
  var_14 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  thread killentireenemyteam(var_8, var_2);
  thread killedenemy(var_6, var_7, var_3);
  var_3 cameraset("_encstr_BECB1681B69DD8CEEA7FCFFBD7639850178D2B39DCEC51A7");
  var_3 thread delay_player_say_attached(9.4);
  var_3 thread delay_player_say_in_air(20.6);
  var_15 = [var_10, var_13, var_11, var_12, var_14];

  foreach(var_17 in var_15) {
    if(!isDefined(var_17))
      var_15 = scripts\engine\utility::array_remove(var_15, var_17);
  }

  var_0 stopuseanimtree();
  var_0 scriptmodelclearanim();
  level notify("_encstr_B6C00E5474B9A12BD318AB0F3009FCCA");
  var_0 hide();
  var_5 show();
  var_5 scriptmodelplayanim("_encstr_BABF29E6919CFA6C07FA1ABDB9A3C2CECAFA8C4EDBC1B799CCFA3B27EDBA7332BE4B9136ACEB0E9636B71D");
  thread cleanupents(var_6, var_7, var_8, var_9, var_5);
  thread keypadkeys(var_3);
  var_4 thread scripts\cp_mp\anim_scene::anim_scene(var_15, "_encstr_BA8E0766EA368EDE9B", 1, 1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
}

keypadkeys(var_0) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  wait 9;
  var_0 cameradefault();
}

killedenemy(var_0, var_1, var_2) {
  wait 6.1;
  var_0 dontinterpolate();
  var_0 show();
  var_1 dontinterpolate();
  var_1 show();

  if(isDefined(var_2) && var_2 scripts\cp_mp\utility\player_utility::_isalive())
    var_2.ability_invulnerable = undefined;

  wait 5.1;
  var_1 hide();
}

delay_player_say_hellyeah(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = 64000000;
  var_3 = cos(130);
  wait(var_0);

  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    if(distance2dsquared(level.players[var_4].origin, var_1.origin) < var_2) {
      if(scripts\engine\utility::within_fov(level.players[var_4].origin, level.players[var_4] getplayerangles(), var_1.origin, var_3))
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(level.players[var_4], "_encstr_B619103363B09DDE93F5387B37A5474B3BCA", undefined, randomfloat(2));
    }
  }
}

delay_player_say_in_air(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  wait(var_0);
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "_encstr_A7C00F671932960BA37AA8383038540B20");
}

delay_player_say_attached(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  wait(var_0);
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "_encstr_8B7D0F0852033F194B8BC90948A99F7914");
}

killentireenemyteam(var_0, var_1) {
  if(!isDefined(var_1))
    wait 11.38;
  else
    wait(var_1);

  var_0 show();
}

anim_hostage_notetrack_handler(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_84610D49100897C2DF809A03583BFF", var_2);

    if(!isDefined(var_2))
      var_2 = ["_encstr_8C500ABA9B23CACC2D37AC8C"];

    if(!isarray(var_2))
      var_2 = [var_2];

    var_3 = undefined;

    foreach(var_5 in var_2) {
      switch (var_5) {
        case "_encstr_96F6108FE13D1263B81E76BEB188B8AA1E77":
          var_0 thread backpack_delayshow();
          var_1 thread chopper_boss_target_tag();
          break;
      }
    }
  }
}

backpack_delayshow() {
  self show();
}

chopper_boss_target_tag() {
  self show();
  wait 5.7;
  self hide();
}

chopper_can_see(var_0) {
  var_0.modifyvehicletoplayerdamage = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin - (0, 0, 192));
  var_0.modifyvehicletoplayerdamage setModel("_encstr_BEDF1A22D8C15FE308ED6947C77068E3F8B0DA89C12F3F1C58336B4B");
  var_0.modifyvehicletoplayerdamage notsolid();
}

anim_hostage_fulton_start(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.ignoreall = 1;
  self.scripted_mode = 1;
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
}

civ_hostage(var_0, var_1) {
  if(istrue(self.was_used)) {
    return;
  }
  self notify("_encstr_8648096DED9DA8CFB722E1");
  level notify("_encstr_B2AE1183D02883F9F417982AEF01C7D1588B8C");
  self.trigger makeunusable();
  self.was_used = 1;
  self.scripted_mode = 0;
  self.ignoreall = 0;
  self.dontkilloff = 0;
  self.health = 10;
  self.maxhealth = 10;
  self.ignoreme = 0;
  var_2 = randomintrange(140, 190);
  scripts\engine\utility::set_movement_speed(var_2);
  self allowedstances("_encstr_A5AD069B231F0BAF");
  var_3 = scripts\engine\utility::getStructArray("_encstr_86321AB248D733AFC9AD47753B733BBE1F68496AE04F2EB360804E7B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = scripts\engine\utility::getclosest(self.origin, var_3);
  var_5 = getclosestpointonnavmesh(var_4.origin);
  self setgoalpos(var_5);
  thread hostage_keep_goal(var_5);
  thread despawn_hostage(4000);
}

hostage_keep_goal(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self setgoalpos(var_0);
    wait 4;
  }
}

civ_init(var_0) {
  var_0 scripts\cp\cp_modular_spawning::update_spawn_data_on_spawn();
  var_0 thread scripts\cp\cp_modular_spawning::_update_spawn_data_on_death();
  var_0.scripted_mode = 1;
  var_0.ignoreall = 1;
  var_0.ignoreme = 1;
  var_0.dontkilloff = 1;
  var_0.health = 100000;
  var_0.maxhealth = 100000;
  var_0.suppressionthreshold = 0.0;
}

ai_used_think(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8FAE0723DEEECDCA19");
  self endon("_encstr_8A12060D5BA9C745");
  self.trigger endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B1900EDCD1BD07D7A5B9E8599C168DD1");

  for(;;) {
    self.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(!istrue(self.interact_disabled)) {
      self[[self.onuse]](var_1, var_0);
      self notify("_encstr_A2911166BDD8D8B7DD5A73ECF51CB1162F95E4", var_1);
    }
  }
}

self_onuse(var_0, var_1) {
  scripts\engine\utility::disable_pain();
  self.ignoreall = 1;
  self.ignoreme = 1;
  self setgoalentity(var_0, 100);
  scripts\cp\cp_modular_spawning::set_goal_radius(256);
  scripts\cp\cp_modular_spawning::set_demeanor_from_unittype("_encstr_830E086EE82B0B361D86");
}

anim_hostage_idle(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8648096DED9DA8CFB722E1");
  self endon("_encstr_A2911166BDD8D8B7DD5A73ECF51CB1162F95E4");

  if(!isDefined(level.spawned_hostage_modules))
    level.spawned_hostage_modules = [];

  if(!scripts\engine\utility::array_contains(level.spawned_hostage_modules, var_1))
    level.spawned_hostage_modules[var_1.group_name] = var_1;

  if(!istrue(level.hostages_disablelookat))
    thread lookat_nearby_players();

  if(!istrue(level.hostages_disablesounds)) {
    thread hostage_cry_idle();
    thread hostage_cry_release();
    thread hostage_seeplayer_frantic();
  }

  scripts\asm\shared\mp\utility::bunkerinteriorkeypads(var_0);
}

anim_hostage_wait_release(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = scripts\engine\utility::_id_143AD("_encstr_8648096DED9DA8CFB722E1", "_encstr_A2911166BDD8D8B7DD5A73ECF51CB1162F95E4");
  scripts\asm\shared\mp\utility::burndowntime(var_0);
  reset_guy(self, var_1);
}

reset_guy(var_0, var_1) {
  var_0 allowedstances("_encstr_922406F1A6FD5E05", "_encstr_A5AD069B231F0BAF", "_encstr_B13D076BED70539F23");
  var_0 scripts\asm\shared\mp\utility::bunkercounteruav();
  var_0 asmsetstate(var_0.asmname, "_encstr_B23511803380AC7750284AD2B188FF2340850C");
  var_0 setlookatentity();
  var_0.headlook_enabled = 1;
  var_0.disableautolookat = 0;
  var_0.deathstate = undefined;
  var_0.deathalias = undefined;
  var_0.ignoreall = 0;
}

set_building_hostage_id(var_0) {
  var_1 = "_encstr_B40101";

  switch (var_0.group_name) {
    case "_encstr_A9D013B9072CDDDCCA19AF43F6E68E163BCAB9EB2C":
    case "_encstr_AB78125B1F09FF85D330F9828017FB5F210DEFC1":
      var_1 = "_encstr_994C023A";
      break;
    case "_encstr_A2D013B938B0DD9B5946F51A7B371D5876B2E6FA98":
    case "_encstr_997812B9070BDD9B9523EB34F6E68EC29DB27DC4":
      var_1 = "_encstr_8B4C024C";
      break;
    case "_encstr_B1D013CD1CB0BBB99546FA86DE378E0BB3596EBE1B":
    case "_encstr_9B781232D7338396512077B3604B442A87E5B1AE":
      var_1 = "_encstr_834C02D8";
      break;
    case "_encstr_8378129301E83B535D790982E0AEF3763B83070C":
    case "_encstr_B4D013E6C10BEECD56C87D347BDC8E2CCE59E67D91":
      var_1 = "_encstr_A14C02D1";
      break;
    case "_encstr_8B781206732F170D4BC3FF68186B83F9078B108F":
    case "_encstr_95D0136E0785DDCD5946AF86B7DC3A0BECAC6EFAAC":
      var_1 = "_encstr_934C02B2";
      break;
    case "_encstr_867812EE3FA78470B998EF4CF84B433E9745B67B":
    case "_encstr_A6D013DB1036C8E2A270274037B75599BA8DEE19F4":
      var_1 = "_encstr_AB4C022B";
      break;
  }

  self.hostage_building_id = var_1;
  self notify("_encstr_861F109D831B784020381AE84F78A1E63B93");
}

lookat_nearby_players() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8648096DED9DA8CFB722E1");
  self endon("_encstr_A2911166BDD8D8B7DD5A73ECF51CB1162F95E4");
  var_0 = 1500;
  var_1 = var_0 * var_0;

  for(;;) {
    var_2 = scripts\cp\utility::give_closest_player_nearby(self.origin, var_1);

    if(isDefined(var_2)) {
      self.nearbyplayer = var_2;
      self setlookatentity(var_2);
    }

    wait 1;
  }
}

request_hostage_id(var_0) {
  if(!isDefined(level.obj_building_hostages_1))
    level.obj_building_hostages_1 = ["_encstr_A34C02BB", "_encstr_A74C0222", "_encstr_A14C023B", "_encstr_AC4C024A", "_encstr_B84C027E"];

  if(!isDefined(level.obj_building_hostages_2))
    level.obj_building_hostages_2 = ["_encstr_A34C02BB", "_encstr_A74C0222", "_encstr_A14C023B", "_encstr_AC4C024A", "_encstr_B84C027E"];

  if(!isDefined(level.obj_building_hostages_3))
    level.obj_building_hostages_3 = ["_encstr_A34C02BB", "_encstr_A74C0222", "_encstr_A14C023B", "_encstr_AC4C024A", "_encstr_B84C027E"];

  if(!isDefined(level.obj_building_hostages_4))
    level.obj_building_hostages_4 = ["_encstr_A34C02BB", "_encstr_A74C0222", "_encstr_A14C023B", "_encstr_AC4C024A", "_encstr_B84C027E"];

  if(!isDefined(level.obj_building_hostages_5))
    level.obj_building_hostages_5 = ["_encstr_A34C02BB", "_encstr_A74C0222", "_encstr_A14C023B", "_encstr_AC4C024A", "_encstr_B84C027E"];

  if(!isDefined(level.obj_building_hostages_6))
    level.obj_building_hostages_6 = ["_encstr_A34C02BB", "_encstr_A74C0222", "_encstr_A14C023B", "_encstr_AC4C024A", "_encstr_B84C027E"];

  var_1 = "_encstr_B40101";

  switch (var_0) {
    case "_encstr_994C023A":
      var_1 = create_myid_from_levelarray(level.obj_building_hostages_1);
      break;
    case "_encstr_8B4C024C":
      var_1 = create_myid_from_levelarray(level.obj_building_hostages_2);
      break;
    case "_encstr_834C02D8":
      var_1 = create_myid_from_levelarray(level.obj_building_hostages_3);
      break;
    case "_encstr_A14C02D1":
      var_1 = create_myid_from_levelarray(level.obj_building_hostages_4);
      break;
    case "_encstr_934C02B2":
      var_1 = create_myid_from_levelarray(level.obj_building_hostages_5);
      break;
    case "_encstr_AB4C022B":
      var_1 = create_myid_from_levelarray(level.obj_building_hostages_6);
      break;
  }

  return var_1;
}

create_myid_from_levelarray(var_0) {
  var_1 = ["_encstr_A34C02BB", "_encstr_A74C0222", "_encstr_A14C023B", "_encstr_AC4C024A", "_encstr_B84C027E"];

  if(isDefined(var_0)) {
    var_2 = scripts\engine\utility::random(var_0);

    if(!isDefined(var_2))
      var_2 = scripts\engine\utility::random(var_1);
    else
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);
  } else
    var_2 = scripts\engine\utility::random(var_1);

  return var_2;
}

set_hostage_aliases(var_0) {
  var_1 = undefined;
  var_2 = self.voice;

  if(var_2 == "_encstr_A1440A8C62AA7519DD2FC0B0")
    var_1 = "_encstr_AB4C022B";
  else
    var_1 = "_encstr_864C0253";

  self.hostage_aliases_idles = [];
  self.hostage_aliases_release = [];
  self.hostage_aliases_exiting = [];
  self.hostage_last_played = "_encstr_B40101";
  var_3 = var_0 + "_encstr_BA4C02DF" + var_1;

  switch (var_3) {
    case "_encstr_84180426AFB6":
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_8BED1EC11B5989FB104F6C73AB0768EFB0D3EBA0877E7B114895B07BDB8757DF";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_8CED1E11A001C8F70731B018BFDFA3F0A204A39F25F91BB7431A2803D30746C2";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_B4ED1E335130AAE808669C25539108A2FED1AF87C358D2B1D828552BD3B91B0F";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_87ED1E33604ECBAB5718A49D5767629F93A89FB710A6036251A96D93DDBF5F08";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_B8ED1E0B5876C3A34FAFACE55F6F5A879BA097BF18AE3B7A59A1759BE5474730";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_82271E6D40A99F5B23374350F67710CF33EB57649F41452114F740A88F5FC3A9";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_AA271E823A5F518943AFF06523DEB3E762736887FBA1DB9DFBDF72939D76B292";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_BD271ED1DB27E6D0921791E301F158B8CFB3C93992CFA6A06D058BD77D297ADF";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_97271E8411193E2B561E7AD22BB883F5A0A1390FB3710227F171E23B89908A7A";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_B2271E3CA9A186A3DE86F2AAA3203B7D2829B1873BF98ABF09F97AB3311806E2";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_8E411B46F0D71B1CB9BED0B6627D0DBD37D1853B59F5AC1E5A3AAFC40C";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_93411B2AA8D7BEA333F83825A7DE8BC5F7A0E292F87FF77BA85507723F";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_9B411B91E1D7B1836EFA0DD6C4BE1AB79B470BEC2BFA5987D2D1F5330C";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_B4411B0712E17B13B6B7A34F93485ABF583BFE4F298905CB83C97722B9";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_85411B7762910B63E6E7F3FF2398AA4F888BAE3F7939D51B3399279649";
      break;
    case "_encstr_821804B7F94A":
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_82341EC8C3FA1B07E67D439962D71A7BCD3A16ECCA7D1B85B1C6DED53AEB9881";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_8F341EBD90794F8BF3073058A607409F033BA7B4AF111791C4237BC89B6F5399";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_92341EDBB9E87230A0DE34BF3BE9600A5609575F7B30BA1963C0ED438B11E3B7";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_A2341E7953410638B311C01992B7B0483BCBEBF7DFA9DE88F4B52873EB4F8A5F";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_AF341ED4934627BA476112EA0AC774DF3B7D594FA5EE7F8611D06AD3C8EF7BDA";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_A5671ED373E8B970EE20D0F03A0120983724567759516BD38D0AE6EEDA19B662";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_92671E7B6398164332FE24D4EFA7495F23B92AFCFD37201AC9F5B94738419A50";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_8F671E910FBEB1C1DCAF1A6689D7347B37D10B3B59EBC92B8D56859BB2F5990C";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_8A671E191EFA3607E6AF1A6626AFD0BDCD1D2C9D95EB93B21B59163795AF4318";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_81671E616B97566002870105F161E8285FC35989023F16301D951B27CD59DA4F";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_97681B6D181F0989B28138B09F41714077BC67549D77B1C11C1B8902A7";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_B2681BA76B36E77B7F1FF19B2BC673D023E0B15FDF49589B38CC0182C3";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_B1681BD9F3E1A69853F120F9721710E85BAB4B573F497D209113CE5B5A";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_8D681BC80FBEC6836E7DA1CC987DA17BE6472CECB2F5CA1E4B1DD7A10C";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_99681B2B4001A0D3F89FABC8A349B0B83EB33F74ADC0F7C8581C061ABF";
      break;
    case "_encstr_971804C62812":
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_93101EB7930F82C8D3396B674A0E980AEF2D7EEFF5E75AE118C87F0F50E61947";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_9B101EC81EBE8D1CCDAF86B6C8FA86B7378E58CE2BD76CB08D1BDBABD1FA4660";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_93101EB7930F82C8D3396B674A0E980AEF2D7EEFF5E75AE118C87F0F50E61B47";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_81101EDA58274E53E328E815768EFB95A7903262284F064F38A9E7056DD6F20A";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_84101E8CF0AFC6839BD7D0DA8C7DD0DEB9E8589D2BAFC6B01BD8ED578EFAA606";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_B4541E85C8984E7A93A7BA28C2B70BFF779B30575D8672CA50787923710F429A";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_85541E1B7928B2F0E09E743D1BA920CA96C9979F3B70EBDDC0212E82E9D122F7";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_96541EC80FAFD883E6AFA1AD8CEB1AED6EA3C2B3CAEB27951B5616CDB2F5660C";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_A1541E19F0D7D81C9BFA1AAD46FAD0DB9B472C3BCAF5E4B2C6CA85B9B2AF1A0C";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_8B541EE5A0A7B1013A19B09027D9C9C8FF34FFEC15FFDB63A582E0984AE13B6B";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_8FAE1B23F0BE6CE0DCD7D0DA19AF34DBB94785CE56F5ACC34BA3AF2681";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_BAAE1B53E91156E0DB50B4203A016BA0133B7F10BFE13B5BC2E3569A93";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_A5AE1B4F5AA9334BFEFF9B874DB09267606386171151FD03DBB13FE671";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_B1AE1B79C879B09F6F699820A7075B188A3CFBE77DD1D8E36FF376036F";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_A6AE1B85580F86AFF0FFF0DA6AE750B74F9B76B759CF5753CA7DEF2DB0";
      break;
    case "_encstr_87180491FA99":
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_82341EC8C3FA1B07E67D439962D71A7BCD3A16ECCA7D1B85B1C6DED53AEB9881";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_B6D71E92106F160BAB10D0D6BE76335D9FC84A3A1097CE8760E1AFDDB59E9232";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_85D71EACB351BE486777215E2B47C9072B1C576CF3C88EF79C6A0DB715CF7EB7";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_93D71E606147579B98E10DA1C23ECB0730DC17601F6F3FEFF0589DFB4117BB5B";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_83D71EE5A0A7B1013A19B0C827D9C9C8FF34FFEC15FFF96BA51290A85BE13B6B";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_B8DD1E144B66F6528727F832022FC0ED324D17802569C2D3D89F93DB11111247";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_A7DD1E5331108AC82846BC07D371E882DEB1CFA7E3B82395B869F64AD1997A2F";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_ACDD1E46E17D6C079BFA1A6623F5867B371D2C3B59EBC9CA36AC85CDAC7D99C0";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_A6DD1E5A12B0AF3AB08F50262DA944D7CE0B82D2196813B760D3513BAB819B72";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_BADD1E7079095B386FE6D247F63F4BFFEBA3B0DF4DA1CB0F18134ACBE08EE6CA";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_87A31B8BD8F64323CF802CA75EEFDA071B20173F982EBD6BD32DF90A47";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_ADA31B23F0AF1B0737EBD0338CAF1ABDDCD1C2CE95BE56F05A477D6403";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_A6A31B8C3CFA1BE09BFA0D6664AFA1BDCDE80BECB2F5593CB447EBCC06";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_A9A31B3D686F79F9C2D168331F9181B0A70C3724CDC76111AC4BD99A57";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_B6A31B23F0F5D8E0CDBED09919D743ED373A0BEC2BAFB20F4B3ABED418";
      break;
    case "_encstr_AC1804F7CFD5":
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_9AC01E2387BE8D83E6F5A16B66F543F6CDA316D956EB361636D8BDD53AF59806";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_8EC01E036120BAF818966C3503A138B28EC19F973348E2A1C818A53BC3C92AFF";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_93C01EAF8B078AB0AB31736F7A0690F2F72576E7FDDF42E910D0773758FE034F";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_95C01E5C0BDEBF32CFD99AC292BFEC57B3F5A1D72D66F73E8958D25B5067B362";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_8AC01EA938773017034791939EA95308F393B141E78FF847CA93E7BBBB71053A";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_A7A21E91F0D7D80E6EFAD06BCCFA0DED9BD1B0CE2B7DC995D82B85B9CAF562C0";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_86A21EE2AA0827B22807A8A5B721FC4F46830A5A91E0AB2FE86BD9A323F992FA";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_ABA21E1987FAC6E0B9FAD0D633D743DEB91DB0D959EB2795B19585DCCA7D6618";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_AAA21E1B4866F3937F30BCF52E7F4AB78B50878F08DE3A0AA935C66A7D574710";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_B2A21EE44396F76A9791E28ACAF7248F4B2D699F553E0BF741A87A63109F4B2A";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_86E71B33604ECBAB5718A49D5667629F93A89FB710A605F35BA56182FF";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_A5E81B89A3B1F6C8238150C8A227C038AB7B7B074F194DD04123BE2B8A";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_99E81B85EA211A53B31F2359FB192A6A23D191CF38AF42E21B83BF73AA";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_91E81B320FBE8D076EEB435B66EB34DBE647B03B59EBAC874B1DBEA106";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_ABE81B1850498A524FF168ED5AF7685A97B1810741788563BA7567DF4A";
      break;
    case "_encstr_88180433AF33":
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_B2951E8A10011FBB6310C3715769BA579681F8BFA5C7B7D75A99ED60F077B9FA";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_97951EA91889406F9FB948F107572B68DA8C2B17AD61B83FCBA2A09B5B7FFE4A";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_A6951EED989F89093201B8303FC1F1C0F73CE7D41DF7F173DD1A88A063E93F73";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_8B951E9FBB37BAE0FB6103332A56A02207D5A6D7AD8F7239E0E02767680E341F";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_A7951E91F0FAC6076EBE863399FA34DECD3A85D956EBB1C2C6D87BEAA3AFA660";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_8AF21E230FEBC6C1B9EB3433337D0D7B9B1D0B7659F53959B1B20B9BB27D1306";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_88F21E46E1FAC6E0CDAFA166CCFA0DDBB91D583BCA7D4E56C656B0CDCAFAC881";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_BEF21EDFC09E5E5020C730876BA903E0C3E54217EF27C079812FEA3805AE4BA1";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_83F21E07239F125843C99BDBD2BE089A9FBDCE7F0577FB958830B7874896ACB7";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_9AF21E233CD7B1C19BFA1A6699BE1AB79BA3C29D56D74EAC1BACC29BCAD74D06";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_84E11B0A42E0DF4AC0DF68161F7994271E3BD2A249589F1E78A13F49F1";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_8FE11BB2304F362B8B70B0B65E56137D7F286A1A70F76FC320CDBFFAB7";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_92E11B97AB47A950561FA8C343D10AAF9B6B67972311ADDB38838F1AA7";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_8FE11BB2304F362B8B70B0B65E56137D7F286A1A70F76FC320CDBFFCB7";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_ABE11BE9C3D196A843E13089820720D84B5B5B672F396D306103DEEB6A";
      break;
    case "_encstr_BE18040DBEB5":
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_83581EC8E1FA360E6EF5A1B50DBE43BDDC3AC23B59F5D82CC61BDBEA3A7D8918";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_8C581E8C0FD71BC1CDFA865B0DEB867BE61D85CE56BE8DC21B36B7EAE8F5460C";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_8B581EE5A0A7B1013A19B09047D9C9C8FF34FFEC15FFF96BA51290A85BE1376B";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_8A581E89837F4E782AAF393BEC1980B767DBA1913A27F63805642F33B4712A77";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_B4581E85C8984E7A93A7BA28F2B70BFF779B30575D86638A5030B843530F439A";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_BDAC1EBD90794F8BF307306BB207409F033BA7B4AF113511C40770F8DF6F3399";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_97AC1EA3B098FFE1BB69608A571F29AA13C3CE5C4D317641C0F3D2EAF8B1424A";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_87AC1E6CF9F1D6D3AEF6A2FAB390EB8DF899E1F76B495A4FD9A90A03E1C84E92";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_8BAC1E6493317223F3190B65BBCF6B887B53460C60DF258AAC4D1917EA38EA7F";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_8CAC1EFBA88613739FD09CD58D1F2AD7AB70676F28FE5A6A89D5264A1D77B730";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_8C511B321EFAC6E06EAF0DAD1ABED0B7B91D0BD959FA2B1E5AE8AF62C0";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_86511BD253992BC97071E8325F77D83FF0EB10CA9581A23322D57F7AFB";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_A7511B21B0EFA88F8BBF190B0A11DB807B0B09D91F074043027B7FBF32";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_96511B320FFAB13837FAD05BD0D7867BE61D587656FA591E2D8ED7A1C0";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_AD511BD810EFF39257E1B0E7827F3BC0E3CB4A3F6F6768EBAA2DA7B2C9";
      break;
    case "_encstr_811804EB21EC":
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_88471E59E85990BF4F8978A127277B38EA5CDBC79D31C80F1B5290CB0B4F8F7A";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_85471EC451597E6B165E3AA24B78433560E1794FF3B186F7B110429B6B50D23A";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_96471EBAE08759C35B090C7F7C49E870DBD30B6077D1CBC31859A0B5D851BAAA";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_BE471E3473A6C75AA7C1B24A82A714BF9BDDB9AF054E1F26B130CA73A84FDB7A";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_A3471E0D383F29A992A118502FA1516057DC0774BD9791D33DFA28C0C349D3D3";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_B8221EC81EF5D8C1E6AFD0330DFAD07B378E0B9DCAFA93CA635916B9B2D76206";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_87221EFFDB57DA809B01A393B2F640C2A77506B7CD2F83DD40C87FDF2BAE527F";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_AD221E8CE1EB1BE0B97D0DCC1AF586F6DCD12C76B2BEE4CA3659C23759F5CC0C";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_8C221E5F7BF77A203BA1C3F3D296E0624795E6176D4F237DA068DFBFA04EF4DF";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_8B221E616041515B207E8148C7A181377B1BA0695B185AA86C6F31B6CAB7EBFF";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_87491B2AA8D7BEA333F8382E25DE8BC5F7A0E292F87FF77BA85507713F";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_97491B024AE8C752C8E7080E19819C2F2623AABA7140970860A90742E9";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_87491B2AA8D7BEA333F8382E25DE8BC5F7A0E292F87FF77BA85507733F";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_B8491B3B590892D09B7E941FFB8968AAF6A9B7BFDB50BAA08823417363";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_A1491BD1DB27E6D0921791F504F158B8CFB3C93992CF2D482C14F75B28";
      break;
    case "_encstr_8B18049EB1E0":
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_88291E79F8F710AF171E7B63FB8FE03AF8A3A73F8227BA47801B821333DFAAD2";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_85291E321E7DD8386EEB43ADD4FAD0DB9BE8163B2BF5C60BD81BBDD5E87D6481";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_88291E79F8F710AF171E7B63FB8FE03AF8A3A73F8227BA47801B821333DF2AD2";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_BE291ECC595176730E56421A73704B2D98F941578BA9BEFFB9284A8363A8F232";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_A3291EE1EB17D6E08207819375E168A8DF43D90982BF1E909D1C87AB5CD95ACF";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_AA9A1E3287D71B839B7D86D66AEB43DE9B1D167656AF935663CA2C6EB27D1318";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_B29A1E60A31F51D903F913A95BF9D1189B0BC0803FC7CBBB9A1F9FAEA711ADAB";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_B19A1EF0338FA129F3698319EB6941680BBB5070AF775BCB2A8F0F1ED7813F3B";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_AB9A1EC88307A9A81BCFD8E80207A82FEFB949B0EF97AD775C350B6348808CFF";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_919A1E219031F8E71721C068EFCF93E052F4B3AF35E9B8A5B3BAF9D3F2F7F5D2";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_8DC11B2F7390E7EBFA110331DF5E38F007C1C91F407F527B10FC57FAB7";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_9BC11BECBB6E0F629F89EAB2F2EF5C87432571675D365FA87328817FC2";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_AFC11B5331108AC82846BCC53371E882DEB1CFA7E3B85288904B795A7B";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_B1C11B23C3BE8D07B9FA1AAD9AEB86DECD3A0BD9CAFAACF0A5D1D7D006";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_B2C11BF0338FA129F3698319EB6941680BBB5070AF77B9F17ACB103D82";
      break;
    case "_encstr_951804C2C750":
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_83DD1E11A001C8F70731B079FFDFA3F0A204A39F25F91BB7431A2803D307C7C2";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_9ADD1E46F0EBB1E0B9F586CCA9EB86B7B9A32CD9567DD8B08D63EDAE8EFA2381";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_83DD1E11A001C8F70731B079FFDFA3F0A204A39F25F91BB7431A2803D307C6C2";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_8ADD1E23E1AF6CE0B9F51ACC9AEBA1DE9B472CB3CAAF1B85B11BDEEAD1BED060";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "_encstr_95DD1E89185710372367F1E5E6C9732813735161C7EFD8672AB3C7DB9B91E51A";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_99011E911E7F381F1B4FE98D9EA16B100B9BB949EF97485DC28FF3AFF7890F32";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_8F011EC81ED71B07B9FA1A66A9F534DBB98E0B9D95AFE4B2B1950B6E2BFA1960";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_99011E911E7F381F1B4FE98D9EA16B100B9BB949EF97485DC28FF3AFF7890E32";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_B2011EB8D84F377820CF18B087C7FAE0839D985A7B790BFB31FB310657E66DD7";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "_encstr_97011E9BF9A83270601EF47F7B29A04A1649171FBBF06B5D40A1AE026951A577";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_A2A71B6520273181BA993048D75949487FB47F6C957FB9D96413910A9F";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_AFA71BE9B2EFD1401AB94AAB4BD759388FA987CF21C13D900A6BC9A28A";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_83A71B2387BEB10E9BFA4399D4BE347BE6A32C7656FAB21E2D1DEBCC81";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_92A71B5953AF7E481A9F697D9D49D030B72B71A16A57A5C0B4AC7FC1A0";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "_encstr_81A71B6CF9F1D6D3AEF6A24A9390EB8DF899E1F76B499F3B5B8BE9674B";
      break;
  }
}

hostage_seeplayer_frantic() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8648096DED9DA8CFB722E1");
  self endon("_encstr_A2911166BDD8D8B7DD5A73ECF51CB1162F95E4");
  var_0 = 0;
  var_1 = 8000;
  var_2 = 300;
  var_3 = var_2 * var_2;
  var_4 = 1500;
  var_5 = var_4 * var_4;

  for(;;) {
    wait 0.2;

    if(!isDefined(self.nearbyplayer)) {
      continue;
    }
    for(var_6 = 0; var_6 < level.players.size; var_6++) {
      if(distance2dsquared(self.origin, level.players[var_6].origin) > var_5) {
        continue;
      }
      if(distance2dsquared(self.origin, level.players[var_6].origin) < var_3) {
        var_0 = gettime();
        break;
      }

      var_7 = sighttracepassed(level.players[var_6] getEye(), self getEye(), 0, level.players[var_6]);

      if(var_7) {
        var_0 = gettime();
        break;
      }
    }

    wait(randomfloatrange(0.1, 0.5));

    if(gettime() < var_0 + var_1) {
      self.hostage_saw_player_recently = 1;
      thread hostage_seeplayer_frantic_share();
      continue;
    }

    self.hostage_saw_player_recently = 0;
  }
}

hostage_seeplayer_frantic_share() {
  var_0 = 1100;
  var_1 = var_0 * var_0;
  wait(randomfloatrange(2, 4.5));

  foreach(var_3 in level.spawned_hostage_modules) {
    for(var_4 = 0; var_4 < var_3.ai_spawned.size; var_4++) {
      if(distance2dsquared(self.origin, var_3.ai_spawned[var_4].origin) < var_1)
        var_3.ai_spawned[var_4].hostage_saw_player_recently = 1;
    }

    waitframe();
  }
}

hostage_cry_idle() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8648096DED9DA8CFB722E1");
  self endon("_encstr_A2911166BDD8D8B7DD5A73ECF51CB1162F95E4");

  if(!isDefined(level.obj_last_hostage_vo))
    level.obj_last_hostage_vo = "_encstr_B40101";

  if(!isDefined(self.hostage_id)) {
    if(!isDefined(self.hostage_building_id))
      self waittill("_encstr_861F109D831B784020381AE84F78A1E63B93");

    self.hostage_id = request_hostage_id(self.hostage_building_id);
    set_hostage_aliases(self.hostage_id);
  }

  var_0 = 0;
  var_1 = 4000;

  for(;;) {
    wait 0.05;

    if(!isDefined(self.nearbyplayer)) {
      continue;
    }
    if(istrue(self.hostage_saw_player_recently)) {
      if(gettime() > var_0 + var_1) {
        var_0 = gettime();
        var_2 = scripts\engine\utility::random(self.hostage_aliases_idles);

        if(!isDefined(var_2)) {
          return;
        }
        while(var_2 == self.hostage_last_played)
          var_2 = scripts\engine\utility::random(self.hostage_aliases_idles);

        var_1 = var_1 + randomintrange(0, 1200);
        var_3 = self gettagorigin("_encstr_A130084D2FDAD8AA8F62");
        thread hostage_play_sound_idle(var_3, var_2);
        self.hostage_last_played = var_2;
        level.obj_last_hostage_vo = var_2;
      }
    }
  }
}

hostage_play_sound_idle(var_0, var_1) {
  self.soundent = scripts\engine\utility::spawn_tag_origin(var_0);
  self.soundent playSound(var_1);
  var_2 = lookupsoundlength(var_1);
  var_2 = var_2 / 1000;
  wait(var_2);

  if(isDefined(self.soundent) && isent(self.soundent) && istrue(self.soundent.delaykill))
    waitframe();

  if(isent(self.soundent))
    self.soundent delete();
}

hostage_cry_release() {
  self endon("_encstr_AD75063D571AE108");
  scripts\engine\utility::_id_143A5("_encstr_8648096DED9DA8CFB722E1", "_encstr_A2911166BDD8D8B7DD5A73ECF51CB1162F95E4");

  if(!isDefined(self.hostage_id)) {
    self.hostage_id = request_hostage_id(self.hostage_building_id);
    set_hostage_aliases(self.hostage_id);
  }

  if(isDefined(self.soundent)) {
    self.soundent stopsounds();
    self.soundent.delaykill = 1;
  }

  wait 0.1;
  var_0 = scripts\engine\utility::random(self.hostage_aliases_release);
  self playsoundonmovingent(var_0);
  self.hostage_last_played = var_0;

  if(istrue(self.disable_exit_sounds)) {
    return;
  }
  var_1 = lookupsoundlength(var_0);
  var_1 = var_1 / 1000;
  wait(var_1 + 1.15);

  for(var_2 = 0; var_2 < 8; var_2++) {
    var_0 = scripts\engine\utility::random(self.hostage_aliases_exiting);
    self playsoundonmovingent(var_0);
    self.hostage_last_played = var_0;
    var_3 = randomfloatrange(5.5, 12);
    wait(var_3);
  }
}

cleanupents(var_0, var_1, var_2, var_3, var_4, var_5) {
  wait 40;

  if(isDefined(var_0) && isent(var_0))
    var_0 delete();

  if(isDefined(var_1) && isent(var_1))
    var_1 delete();

  if(isDefined(var_2) && isent(var_2))
    var_2 delete();

  if(isDefined(var_3) && isent(var_3))
    var_3 delete();

  if(isDefined(var_4) && isDefined(var_4.modifyvehicletoplayerdamage) && isent(var_4.modifyvehicletoplayerdamage))
    var_4.modifyvehicletoplayerdamage delete();

  if(isDefined(var_5) && isent(var_5)) {
    if(var_5 islinked())
      var_5 unlink();

    var_5.origin = var_5.origin - (0, 0, 15000);
    var_5 dodamage(500, var_5.origin, var_5);
  }

  if(isDefined(var_4) && isent(var_4))
    var_4 delete();
}