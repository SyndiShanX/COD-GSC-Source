/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\infilexfil\cp_fulton.gsc
***********************************************/

fulton_group_exfil_at_pos(var_0, var_1, var_2, var_3) {
  level thread fulton_group_exfil_at_pos_internal(var_0, var_1, var_2, var_3);
}

fulton_group_exfil_at_pos_internal(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.origin = var_0;
  var_4.angles = var_1;
  var_4.buildweaponfromrandomcategory = var_3;
  var_5 = 120;

  if(isDefined(var_2))
    var_5 = var_2;

  level thread anim_init_exfil_fulton();
  level thread launch_evac_box(var_5, var_4);
  level thread _id_1353A(var_0, var_1, var_4);
}

_id_1353A(var_0, var_1, var_2) {
  var_3 = var_0 - (0, 0, 192);
  var_2.modsforclass = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
  var_2.modsforclass setModel("_encstr_84141CFD43F0CC4B2FEB3B41717D63C390255779CFA017D7468D3349B856");
}

launch_evac_box(var_0, var_1) {
  level thread temp_move_exfil_box(var_1);
  var_2 = 3;

  if(var_0 > 3)
    var_2 = var_0;

  wait(var_2);
  level notify("_encstr_B4C40E59F36FF7319FB67B77F706E8BB");
}

init_crate_type() {
  if(isDefined(level.cratedata.configs["_encstr_9B7010D838F5CC573647BD737DB2F066B4C6"])) {
    return;
  }
  level.cratedata.configs["_encstr_9B7010D838F5CC573647BD737DB2F066B4C6"] = scripts\cp_mp\killstreaks\airdrop::getemptyleveldata();
  level.cratedata.configs["_encstr_9B7010D838F5CC573647BD737DB2F066B4C6"].friendlymodel = "_encstr_84141CFD43F0CC4B2FEB3B41717D63C390255779CFA017D7468D3349B856";
}

play_airdrop_crate(var_0) {
  level init_crate_type();
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = (0, 0, 0);

  if(isDefined(var_0.buildweaponfromrandomcategory))
    var_3 = var_0.buildweaponfromrandomcategory;

  var_4 = 1024000000;
  var_5 = scripts\cp\utility::give_closest_player_nearby(var_1, var_4, "_encstr_9A8507BA4040188D08");
  var_6 = var_5 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_B40101", var_5);
  var_6.numcrates = 1;
  var_6.cratetype = "_encstr_9B7010D838F5CC573647BD737DB2F066B4C6";
  var_6.scenenodeoffset = var_3;
  var_6.usephysics = 1;
  var_7 = scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_dropcrates;
  var_8 = level thread[[var_7]](var_5, var_5.team, var_1, var_2, var_1, var_6);
  waitframe();
  var_9 = undefined;

  foreach(var_11 in var_8.crates) {
    var_9 = var_11;
    break;
  }

  return var_9;
}

temp_move_exfil_box(var_0) {
  var_1 = spawn_fulton_crate_model(var_0);
  var_1 hide();
  level waittill("_encstr_B4C40E59F36FF7319FB67B77F706E8BB");
  var_2 = level play_airdrop_crate(var_0);
  var_2 hide();
  var_2.isdummyarmcrate = 1;
  var_2 scripts\cp_mp\killstreaks\airdrop::deactivatecrate();
  var_2 scripts\engine\utility::delaythread(2, scripts\cp_mp\killstreaks\airdrop::deactivatecrate);
  var_2 dontinterpolate();
  var_2.heli_assault3_death_watcher = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_3 = getdvarint("_encstr_B83923CF184B576AFB2103FD18F3C3241360F75B61C3A3F33BC70B7676B92AFAFBA85F8740", 0);

  if(var_3 > 0) {
    var_2.heli_assault3_death_watcher setModel("_encstr_84141CFD43F0CC4B2FEB3B41717D63C390255779CFA017D7468D3349B856");
    var_2.heli_assault3_death_watcher.angles = var_2.angles;
    var_2.heli_assault3_death_watcher setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_A7C5056BD931D1");
  } else {
    var_2.heli_assault3_death_watcher setModel("_encstr_8B291970848CA8DDFA3B0BBF9343298857DDBE49AAFBB019E26B03");
    var_2.heli_assault3_death_watcher.angles = var_2.friendlymodel.angles;
    var_2.heli_assault3_death_watcher linkTo(var_2.friendlymodel, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_2.heli_assault3_death_watcher thread playerstreamwaittillcomplete();
    var_2.friendlymodel hide();
  }

  var_2 waittill("_encstr_AC7F0EF01AA4DBEE937920AB5B939181");
  var_4 = var_2.origin;
  var_2.angles = var_0.angles;
  var_2.physicsactivated = 0;
  var_2.friendlymodel hide();
  waitframe();
  var_2.heli_assault3_death_watcher.angles = var_0.angles;
  var_5 = var_4[2];
  var_6 = var_5 - (var_0.origin[2] + 100);
  var_7 = var_5 - var_0.origin[2];

  if(var_6 > 0) {
    var_8 = (var_2.angles[0], var_2.angles[1] + 180, var_2.angles[2]);
    var_2 dontinterpolate();
    var_2.origin = var_4;
    var_2.angles = var_8;
    var_2.heli_assault3_death_watcher dontinterpolate();
    var_2.heli_assault3_death_watcher.origin = var_4;
    var_2.heli_assault3_death_watcher.angles = var_8;
    var_9 = var_7 / 400;
    var_10 = max(var_9 * 0.33 - 0.05, 0.05);
    var_2 moveTo(var_0.origin + (0, 0, 8), var_9, var_10, 0.05);
    var_2.heli_assault3_death_watcher moveTo(var_0.origin + (0, 0, 8), var_9, var_10, 0.05);
    var_2.heli_assault3_death_watcher rotateTo(var_0.angles, var_9, 0.05, 0.05);
    wait(var_9);
  }

  var_2 playRumbleOnEntity("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9");
  earthquake(0.2, 0.75, var_2.origin, 600);
  var_2 playSound("_encstr_994221202E7D56BE900E4F053008FADF921B48D36F128FAA1BF9AB0769D08DC9214EEB");
  waitframe();
  var_2 scripts\cp_mp\killstreaks\airdrop::deactivatecrate(1);
  level thread delayed_enable_fulton_extract(var_1, var_2, var_0);
}

spawn_fulton_crate_model(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_3 setModel("_encstr_8B291970848CA8DDFA3B0BBF9343298857DDBE49AAFBB019E26B03");
  var_3.angles = var_2;
  var_3.targetname = "_encstr_9ACE19371569F3D770394757484980EACFA27EEFF5E7BAEF198073";
  return var_3;
}

playerstreamwaittillcomplete() {
  self hide();
  wait 6;
  self show();
  self dontinterpolate();
  self scriptmodelplayanim("_encstr_8AC223493A771895F2EB9F952F2A5E08F5927621E7A6A8465A5FFF89D7B32D9887AC99B80F");
  self hidepart("_encstr_B8BF1170C9A38D503347FDA7725C88DD9FD7E3");
  self hidepart("_encstr_9130159AEB13B01BF6DBDCBEB1EE93EB1D4B0E7D91EEE6");
  self hidepart("_encstr_BDBE15A6F58916D8F6BDCDD7AD2D32FAA32DC17D19BBDC");
  self hidepart("_encstr_AC6E15B819763378476F30A06DE363875BC2E089C24B75");
}

delayed_enable_fulton_extract(var_0, var_1, var_2) {
  level thread infil_name(var_0, var_1, var_2);
  level thread play_crate_vfx(var_0);
  level thread create_fulton_group_interactions(var_0, var_2);
  level thread track_fulton_uses();
  level.obj_allow_fulton = 1;
}

infil_name(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_2.origin;
  var_3.angles = var_2.angles;
  var_0 thread _id_14402(var_1);
  var_0 thread _id_14401();
  var_4 = thread _id_13559(var_3);
  var_5 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_4, "_encstr_8B880DFAA82963324D26E91BF7D72A");
  var_5 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  level thread _id_123BF(var_3, 0.2, var_5, var_4);
  var_6 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_0, "_encstr_9690073295D94B8D59");
  var_6 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  var_5 baloon_deposit_death_check("_encstr_A937066AFF52FA4F");
  var_6 baloon_deposit_death_check("_encstr_8F9E06C26033F37F");
  var_0 dontinterpolate();
  var_4 dontinterpolate();
  var_3 scripts\cp_mp\anim_scene::anim_scene([var_6], "_encstr_85A60D17BDFD827BB1D9E7A798EB20", 1, 0);
  var_3 scripts\cp_mp\anim_scene::anim_scene_stop();
  level waittill("_encstr_AC451A1F3D32D3F67EC768A0479E0E13ABE61E30938AA7F9348B3868");

  foreach(var_8 in level.playerstoptimerdelete) {
    var_8.entity playsoundonmovingent("_encstr_92E91FAB1EA6317ED3A72F0D4FAB3FE94673B0C3851E79252B5B0B2977538B281C");
    var_8.entity thread _id_12498();
    var_8 thread _id_123EB(var_6);
  }

  var_3 thread scripts\cp_mp\anim_scene::anim_scene([var_5, var_6], "_encstr_8D500CE2F76B43E81DDFF9BC3323", 0, 0);
}

_id_12498() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  wait 2.2;
  self playRumbleOnEntity("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");
  scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_8C4A10BA936F7F31D0159D6ECB304757814B", "_encstr_8E440A950FE01BB76E96BDE6", 1.5, 0);
  wait(randomfloatrange(0.2, 1.1));
  scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "_encstr_8FF010F221D7301FBECF0F558B4B9EACE351");
  wait(randomfloatrange(2.8, 3.4));
  scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "_encstr_81220F60E331839763E987947F2BCFA89D");
}

_id_123EB(var_0) {
  var_1 = self;
  var_2 = var_1.auto_respawn_timer;
  var_3 = var_1.audio_stop_obj_room_fires;
  var_4 = undefined;

  switch (var_3) {
    case 1:
      var_4 = "_encstr_A6CA16D84E85E895AFA1BDB75BBECCB57D24697D6C8E2763";
      break;
    case 2:
      var_4 = "_encstr_A505161B27C2A3957D43EDF65B7D99ADAFA44AEB8DD19336";
      break;
    case 3:
      var_4 = "_encstr_8264161B9CB08E56D70DDEDE6DBE66DAAF1351EB1BE8C9D8";
      break;
    case 4:
      var_4 = "_encstr_A2FA163A43BFC34FE1F1475FEFB9D7F7C8BDA161C98D03C5";
      break;
  }

  var_5 = var_0.entity scripts\engine\utility::spawn_tag_origin();
  var_5 linkTo(var_0.entity, var_4, (0, 0, 0), (0, 0, 0));
  var_2.entity linkTo(var_5, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1.player_rig linkTo(var_5, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.entity.origin);
  var_6 setModel(var_1.entity.model);
  var_6.angles = var_1.entity.angles;
  var_6 linkTo(var_5, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_7 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_6, "_encstr_8B75083B2D59F08D6337" + var_3);
  var_7 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  thread _id_11AA5(var_1, var_6);
  var_5 thread scripts\cp_mp\anim_scene::anim_scene([var_1, var_2, var_7], "_encstr_8D500CE2F76B43E81DDFF9BC3323", 0, 0);
}

_id_11AA5(var_0, var_1) {
  var_1 hide();
  wait 2;

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    if(var_0.entity != level.players[var_2])
      var_1 showtoplayer(level.players[var_2]);
  }

  var_0.entity playerhide();
}

baloon_deposit_death_check(var_0) {
  if(!isDefined(level.playerstarttimetracking))
    level.playerstarttimetracking = [];

  self.type = var_0;
  level.playerstarttimetracking[level.playerstarttimetracking.size] = self;
}

ballowexecutions(var_0, var_1) {
  if(!isDefined(level.playerstoptimerdelete))
    level.playerstoptimerdelete = [];

  self.auto_respawn_timer = var_0;
  self.audio_stop_obj_room_fires = var_1;
  level.playerstoptimerdelete[level.playerstoptimerdelete.size] = self;
}

_id_14402(var_0) {
  wait 1;
  self show();
  var_0.heli_assault3_death_watcher delete();
  var_0 scripts\cp_mp\killstreaks\airdrop::destroycrate(1);
}

_id_14401() {
  wait 2;
  self playRumbleOnEntity("_encstr_B14F0D7B2B51F287F03ED59C51F0DC");
  earthquake(0.1, 0.45, self.origin, 600);
}

play_crate_vfx(var_0) {
  playFX(scripts\engine\utility::getfx("_encstr_A9251935E93AAF09CF2B1183DB0F1710187E2310A07FB927BD583B"), var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
}

create_fulton_group_interactions(var_0, var_1) {
  level.playertakeextractionplunder = var_0;
  var_2 = 16;
  wait 2.5;
  var_3 = var_0.origin + rotatevector((0, 35, var_2), var_1.angles);
  var_4 = thread spawn_fulton_group_use_interaction(var_3, var_0.angles, 4, var_0, var_1);
  var_5 = var_0.origin + rotatevector((-35, 0, var_2), var_1.angles);
  var_6 = thread spawn_fulton_group_use_interaction(var_5, var_0.angles, 3, var_0, var_1);
  var_7 = var_0.origin + rotatevector((35, 0, var_2), var_1.angles);
  var_8 = thread spawn_fulton_group_use_interaction(var_7, var_0.angles, 2, var_0, var_1);
  var_9 = var_0.origin + rotatevector((0, -35, var_2), var_1.angles);
  var_10 = thread spawn_fulton_group_use_interaction(var_9, var_0.angles, 1, var_0, var_1);
  level.fulton_interactions = [];
  level.fulton_interactions[level.fulton_interactions.size] = var_4;
  level.fulton_interactions[level.fulton_interactions.size] = var_6;
  level.fulton_interactions[level.fulton_interactions.size] = var_8;
  level.fulton_interactions[level.fulton_interactions.size] = var_10;
}

spawn_fulton_group_use_interaction(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\engine\utility::spawn_tag_origin(var_0, var_1);
  var_5 show();
  var_5 setHintString(&"_encstr_ABA72AD005FAA2AAA092A49523D77A842551A11552CA544DBC0D3D93AC3D2B1ABE64558915E9E4FA556A5494");
  var_5 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_5 sethinticon("_encstr_878A17670948A381C03E139E9230C70AB8690FFBBB096B7770");
  var_5 sethintdisplayrange(500);
  var_5 sethintdisplayfov(110);
  var_5 setuserange(128);
  var_5 setusefov(110);
  var_5 sethintonobstruction("_encstr_BECC055CF3811A");
  var_5 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_5 makeusable();
  var_5 thread fulton_group_use_think(120, var_2, var_3, var_4);
  return var_5;
}

fulton_group_use_think(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_4);

    if(isDefined(var_4)) {
      if(!var_4 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      activate_group_fulton_interact(var_4, var_1, var_2, var_3);
      remove_group_fulton_interact(var_0);
    }
  }
}

activate_group_fulton_interact(var_0, var_1, var_2, var_3) {
  var_0.used_fulton_interact = 1;
  var_0.ability_invulnerable = 1;
  level.fulton_interactions = scripts\engine\utility::array_remove(level.fulton_interactions, self);
  var_0 disableusability();
  level thread anim_fulton_exfil_player_scene(undefined, var_0, var_1, var_2, var_3);
  level notify("_encstr_9A1C14838DB05ECA27AF5DB9CA91D72BC3E84EB0C68E", var_0);
  scripts\cp\cp_outofbounds::enableoobimmunity(var_0);
}

remove_group_fulton_interact(var_0) {
  self makeunusable();
  wait(var_0);
  self delete();
}

listen_for_emp_drone_ent(var_0) {
  if(isDefined(var_0))
    wait(var_0);

  level.playertouching = 1;

  foreach(var_2 in level.fulton_interactions)
  var_2 makeunusable();
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

anim_init_exfil_fulton() {
  if(isDefined(level.scr_anim["_encstr_8BB007E03658CBCAE4"]) && isDefined(level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_B25710995D1B1DEDB9AF0DB7DBDA5707EB13"])) {
    return;
  }
  level.scr_animtree["_encstr_93F809831B852F954ED798"] = #animtree;
  level.scr_anim["_encstr_93F809831B852F954ED798"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = % _encstr_A99320D760D938BDB3BB18201147F6B8EBD82769143E988DE3E1DB0E4A0F20200330;
  level.scr_animname["_encstr_93F809831B852F954ED798"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = "_encstr_A99320D760D938BDB3BB18201147F6B8EBD82769143E988DE3E1DB0E4A0F20200330";
  level.scr_eventanim["_encstr_93F809831B852F954ED798"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = "_encstr_A99320D760D938BDB3BB18201147F6B8EBD82769143E988DE3E1DB0E4A0F20200330";
  level.scr_animtree["_encstr_93F809831B852F954ED798"] = #animtree;
  level.scr_anim["_encstr_93F809831B852F954ED798"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = % _encstr_9A0D1E50D7B91D9D258B479DD6E4B2C8F5C0C1CF72D7781DE657E3AF04717C39;
  level.scr_animname["_encstr_93F809831B852F954ED798"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = "_encstr_9A0D1E50D7B91D9D258B479DD6E4B2C8F5C0C1CF72D7781DE657E3AF04717C39";
  level.scr_eventanim["_encstr_93F809831B852F954ED798"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = "_encstr_9A0D1E50D7B91D9D258B479DD6E4B2C8F5C0C1CF72D7781DE657E3AF04717C39";
  level.scr_animtree["_encstr_93F809831B852F954ED798"] = #animtree;
  level.scr_anim["_encstr_93F809831B852F954ED798"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = % _encstr_A1721E221BB8834340C15F56FF70CADFD573799B200F37BF68AF191F93C0D627;
  level.scr_animname["_encstr_93F809831B852F954ED798"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = "_encstr_A1721E221BB8834340C15F56FF70CADFD573799B200F37BF68AF191F93C0D627";
  level.scr_eventanim["_encstr_93F809831B852F954ED798"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = "_encstr_A1721E221BB8834340C15F56FF70CADFD573799B200F37BF68AF191F93C0D627";
  level.scr_animtree["_encstr_ABF8090EB10BBCCA93F5C8"] = #animtree;
  level.scr_anim["_encstr_ABF8090EB10BBCCA93F5C8"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = % _encstr_B2AD202EC9B78D7F99CBA0E859D7321870C3F7D3D273709142E7EABE93E8E02F8B9F;
  level.scr_animname["_encstr_ABF8090EB10BBCCA93F5C8"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = "_encstr_B2AD202EC9B78D7F99CBA0E859D7321870C3F7D3D273709142E7EABE93E8E02F8B9F";
  level.scr_eventanim["_encstr_ABF8090EB10BBCCA93F5C8"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = "_encstr_B2AD202EC9B78D7F99CBA0E859D7321870C3F7D3D273709142E7EABE93E8E02F8B9F";
  level.scr_animtree["_encstr_ABF8090EB10BBCCA93F5C8"] = #animtree;
  level.scr_anim["_encstr_ABF8090EB10BBCCA93F5C8"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = % _encstr_A5C11EE1EFC1123B52115A35D1CF137F3D77FE0A1009681F931072975FD1B80F;
  level.scr_animname["_encstr_ABF8090EB10BBCCA93F5C8"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = "_encstr_A5C11EE1EFC1123B52115A35D1CF137F3D77FE0A1009681F931072975FD1B80F";
  level.scr_eventanim["_encstr_ABF8090EB10BBCCA93F5C8"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = "_encstr_A5C11EE1EFC1123B52115A35D1CF137F3D77FE0A1009681F931072975FD1B80F";
  level.scr_animtree["_encstr_ABF8090EB10BBCCA93F5C8"] = #animtree;
  level.scr_anim["_encstr_ABF8090EB10BBCCA93F5C8"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = % _encstr_AF5B1E1B387D33AE63A3F6DCEBB339B7571CEBC11B852FAC9CD791F5596716B1;
  level.scr_animname["_encstr_ABF8090EB10BBCCA93F5C8"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = "_encstr_AF5B1E1B387D33AE63A3F6DCEBB339B7571CEBC11B852FAC9CD791F5596716B1";
  level.scr_eventanim["_encstr_ABF8090EB10BBCCA93F5C8"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = "_encstr_AF5B1E1B387D33AE63A3F6DCEBB339B7571CEBC11B852FAC9CD791F5596716B1";
  level.scr_animtree["_encstr_A7F8098336C2E5AC4EEBCC"] = #animtree;
  level.scr_anim["_encstr_A7F8098336C2E5AC4EEBCC"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = % _encstr_8453209793A164F00C7B80B8A9EF9328FB7B77395BEAB3084A9903968CDFB05253E3;
  level.scr_animname["_encstr_A7F8098336C2E5AC4EEBCC"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = "_encstr_8453209793A164F00C7B80B8A9EF9328FB7B77395BEAB3084A9903968CDFB05253E3";
  level.scr_eventanim["_encstr_A7F8098336C2E5AC4EEBCC"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = "_encstr_8453209793A164F00C7B80B8A9EF9328FB7B77395BEAB3084A9903968CDFB05253E3";
  level.scr_animtree["_encstr_A7F8098336C2E5AC4EEBCC"] = #animtree;
  level.scr_anim["_encstr_A7F8098336C2E5AC4EEBCC"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = % _encstr_821B1E9E32D9E58B4CCB68787F9FA33F83DA189F8D9283F13A4F82F94FB43853;
  level.scr_animname["_encstr_A7F8098336C2E5AC4EEBCC"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = "_encstr_821B1E9E32D9E58B4CCB68787F9FA33F83DA189F8D9283F13A4F82F94FB43853";
  level.scr_eventanim["_encstr_A7F8098336C2E5AC4EEBCC"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = "_encstr_821B1E9E32D9E58B4CCB68787F9FA33F83DA189F8D9283F13A4F82F94FB43853";
  level.scr_animtree["_encstr_A7F8098336C2E5AC4EEBCC"] = #animtree;
  level.scr_anim["_encstr_A7F8098336C2E5AC4EEBCC"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = % _encstr_933E1E5AE8D7FFB7D06D3F2690D9E3C5FB8001E3B003F00FCBC06B1F95C3770E;
  level.scr_animname["_encstr_A7F8098336C2E5AC4EEBCC"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = "_encstr_933E1E5AE8D7FFB7D06D3F2690D9E3C5FB8001E3B003F00FCBC06B1F95C3770E";
  level.scr_eventanim["_encstr_A7F8098336C2E5AC4EEBCC"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = "_encstr_933E1E5AE8D7FFB7D06D3F2690D9E3C5FB8001E3B003F00FCBC06B1F95C3770E";
  level.scr_animtree["_encstr_91F80938B185CBB227FAD0"] = #animtree;
  level.scr_anim["_encstr_91F80938B185CBB227FAD0"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = % _encstr_82F820FBAF7E0BD351208A9291AFCAF793177F60C9C13F9F5561C79910E7C5AF4BFF;
  level.scr_animname["_encstr_91F80938B185CBB227FAD0"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = "_encstr_82F820FBAF7E0BD351208A9291AFCAF793177F60C9C13F9F5561C79910E7C5AF4BFF";
  level.scr_eventanim["_encstr_91F80938B185CBB227FAD0"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = "_encstr_82F820FBAF7E0BD351208A9291AFCAF793177F60C9C13F9F5561C79910E7C5AF4BFF";
  level.scr_animtree["_encstr_91F80938B185CBB227FAD0"] = #animtree;
  level.scr_anim["_encstr_91F80938B185CBB227FAD0"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = % _encstr_A7471E064BF1DBE8F1E16F26073058A7D3D89943E1636B7590E66FDF291290C5;
  level.scr_animname["_encstr_91F80938B185CBB227FAD0"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = "_encstr_A7471E064BF1DBE8F1E16F26073058A7D3D89943E1636B7590E66FDF291290C5";
  level.scr_eventanim["_encstr_91F80938B185CBB227FAD0"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = "_encstr_A7471E064BF1DBE8F1E16F26073058A7D3D89943E1636B7590E66FDF291290C5";
  level.scr_animtree["_encstr_91F80938B185CBB227FAD0"] = #animtree;
  level.scr_anim["_encstr_91F80938B185CBB227FAD0"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = % _encstr_846B1E86E92EF65B5149E8C5D9C89A7793507120107BEB01E5F09C78C773176F;
  level.scr_animname["_encstr_91F80938B185CBB227FAD0"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = "_encstr_846B1E86E92EF65B5149E8C5D9C89A7793507120107BEB01E5F09C78C773176F";
  level.scr_eventanim["_encstr_91F80938B185CBB227FAD0"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = "_encstr_846B1E86E92EF65B5149E8C5D9C89A7793507120107BEB01E5F09C78C773176F";
  level.scr_animtree["_encstr_9690073295D94B8D59"] = #animtree;
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_85A60D17BDFD827BB1D9E7A798EB20"] = % _encstr_A7321D88C0174B7BBC3B8D3E9F477B9523E3C96D60BB1C208F67022780EF38;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_85A60D17BDFD827BB1D9E7A798EB20"] = "_encstr_A7321D88C0174B7BBC3B8D3E9F477B9523E3C96D60BB1C208F67022780EF38";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_85A60D17BDFD827BB1D9E7A798EB20"] = "_encstr_A7321D88C0174B7BBC3B8D3E9F477B9523E3C96D60BB1C208F67022780EF38";
  level.scr_animtree["_encstr_9690073295D94B8D59"] = #animtree;
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_8E780C8C599DD2C6B27DB4918D2B"] = % _encstr_8F7C1C46EA013D438433A0A0B7A7FB77CB92D05D072BEB497587A8E803FD;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_8E780C8C599DD2C6B27DB4918D2B"] = "_encstr_8F7C1C46EA013D438433A0A0B7A7FB77CB92D05D072BEB497587A8E803FD";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_8E780C8C599DD2C6B27DB4918D2B"] = "_encstr_8F7C1C46EA013D438433A0A0B7A7FB77CB92D05D072BEB497587A8E803FD";
  level.scr_animtree["_encstr_9690073295D94B8D59"] = #animtree;
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_AA660E3B8063D98273101ED56007BA9C"] = % _encstr_8AC223493A771895F2EB9F952F2A5E08F5927621E7A6A8465A5FFF89D7B32D9887AC99B80F;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_AA660E3B8063D98273101ED56007BA9C"] = "_encstr_8AC223493A771895F2EB9F952F2A5E08F5927621E7A6A8465A5FFF89D7B32D9887AC99B80F";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_AA660E3B8063D98273101ED56007BA9C"] = "_encstr_8AC223493A771895F2EB9F952F2A5E08F5927621E7A6A8465A5FFF89D7B32D9887AC99B80F";
  level.scr_animtree["_encstr_9690073295D94B8D59"] = #animtree;
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = % _encstr_81E21C038199FFBF59FB8A6266246B751029878C33B844BFF5B622EB890E;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = "_encstr_81E21C038199FFBF59FB8A6266246B751029878C33B844BFF5B622EB890E";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = "_encstr_81E21C038199FFBF59FB8A6266246B751029878C33B844BFF5B622EB890E";
  level.scr_animtree["_encstr_959A08E4DB07CADCAF26"] = #animtree;
  level.scr_anim["_encstr_959A08E4DB07CADCAF26"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = % _encstr_96D81E1B0EEBCCEA631DBD37D77693F65D07EB1ABD7B6DAF89D734DBBDADAEC1;
  level.scr_animname["_encstr_959A08E4DB07CADCAF26"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = "_encstr_96D81E1B0EEBCCEA631DBD37D77693F65D07EB1ABD7B6DAF89D734DBBDADAEC1";
  level.scr_eventanim["_encstr_959A08E4DB07CADCAF26"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = "_encstr_96D81E1B0EEBCCEA631DBD37D77693F65D07EB1ABD7B6DAF89D734DBBDADAEC1";
  level.scr_animtree["_encstr_959A08E4DB07CADCAF26"] = #animtree;
  level.scr_anim["_encstr_959A08E4DB07CADCAF26"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = % _encstr_B8671C2F889F2BAB9CA3275691CC232255B14858225F27F9561FD33913D7;
  level.scr_animname["_encstr_959A08E4DB07CADCAF26"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = "_encstr_B8671C2F889F2BAB9CA3275691CC232255B14858225F27F9561FD33913D7";
  level.scr_eventanim["_encstr_959A08E4DB07CADCAF26"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = "_encstr_B8671C2F889F2BAB9CA3275691CC232255B14858225F27F9561FD33913D7";
  level.scr_animtree["_encstr_959A08E4DB07CADCAF26"] = #animtree;
  level.scr_anim["_encstr_959A08E4DB07CADCAF26"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = % _encstr_85CC1CB7B8D6261391758DC5C8BF5BE73B20CF63A80893F9439817FBCF5F;
  level.scr_animname["_encstr_959A08E4DB07CADCAF26"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = "_encstr_85CC1CB7B8D6261391758DC5C8BF5BE73B20CF63A80893F9439817FBCF5F";
  level.scr_eventanim["_encstr_959A08E4DB07CADCAF26"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = "_encstr_85CC1CB7B8D6261391758DC5C8BF5BE73B20CF63A80893F9439817FBCF5F";
  level.scr_animtree["_encstr_A29A08EB308F5D7B716B"] = #animtree;
  level.scr_anim["_encstr_A29A08EB308F5D7B716B"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = % _encstr_884C1EB11CBECCD58DD1DBDCFA76C9DED538F586DEBD5BBE23FAA1DBBDD6D583;
  level.scr_animname["_encstr_A29A08EB308F5D7B716B"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = "_encstr_884C1EB11CBECCD58DD1DBDCFA76C9DED538F586DEBD5BBE23FAA1DBBDD6D583";
  level.scr_eventanim["_encstr_A29A08EB308F5D7B716B"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = "_encstr_884C1EB11CBECCD58DD1DBDCFA76C9DED538F586DEBD5BBE23FAA1DBBDD6D583";
  level.scr_animtree["_encstr_A29A08EB308F5D7B716B"] = #animtree;
  level.scr_anim["_encstr_A29A08EB308F5D7B716B"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = % _encstr_A5F91C6C83D733AED88EDECDEBD94EBDAB83FAD07BDED6FA64D7A523B1B2;
  level.scr_animname["_encstr_A29A08EB308F5D7B716B"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = "_encstr_A5F91C6C83D733AED88EDECDEBD94EBDAB83FAD07BDED6FA64D7A523B1B2";
  level.scr_eventanim["_encstr_A29A08EB308F5D7B716B"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = "_encstr_A5F91C6C83D733AED88EDECDEBD94EBDAB83FAD07BDED6FA64D7A523B1B2";
  level.scr_animtree["_encstr_A29A08EB308F5D7B716B"] = #animtree;
  level.scr_anim["_encstr_A29A08EB308F5D7B716B"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = % _encstr_B61D1CB183AF99EA6347B773F59D277BBAE0BE43DBEDADEB19FA2B9DC26C;
  level.scr_animname["_encstr_A29A08EB308F5D7B716B"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = "_encstr_B61D1CB183AF99EA6347B773F59D277BBAE0BE43DBEDADEB19FA2B9DC26C";
  level.scr_eventanim["_encstr_A29A08EB308F5D7B716B"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = "_encstr_B61D1CB183AF99EA6347B773F59D277BBAE0BE43DBEDADEB19FA2B9DC26C";
  level.scr_animtree["_encstr_AF1907EBFF274A478A"] = #animtree;
  level.scr_anim["_encstr_B19A08406FA0612F3172"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = % _encstr_A1A71E988351452323EC2890EF278B0F83EB0148EAF597BEA6DFA318A74F53F9;
  level.scr_animname["_encstr_B19A08406FA0612F3172"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = "_encstr_A1A71E988351452323EC2890EF278B0F83EB0148EAF597BEA6DFA318A74F53F9";
  level.scr_eventanim["_encstr_B19A08406FA0612F3172"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = "_encstr_A1A71E988351452323EC2890EF278B0F83EB0148EAF597BEA6DFA318A74F53F9";
  level.scr_animtree["_encstr_B19A08406FA0612F3172"] = #animtree;
  level.scr_anim["_encstr_B19A08406FA0612F3172"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = % _encstr_936B1CB138FA33BA1B1DBDCDAFCEC9BD5707AF437BDEB6F566BEB48CB159;
  level.scr_animname["_encstr_B19A08406FA0612F3172"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = "_encstr_936B1CB138FA33BA1B1DBDCDAFCEC9BD5707AF437BDEB6F566BEB48CB159";
  level.scr_eventanim["_encstr_B19A08406FA0612F3172"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = "_encstr_936B1CB138FA33BA1B1DBDCDAFCEC9BD5707AF437BDEB6F566BEB48CB159";
  level.scr_animtree["_encstr_B19A08406FA0612F3172"] = #animtree;
  level.scr_anim["_encstr_B19A08406FA0612F3172"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = % _encstr_BE061C26C7BF627D80B0A79BD1D932BAB35FA19C20770A8F830187F34831;
  level.scr_animname["_encstr_B19A08406FA0612F3172"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = "_encstr_BE061C26C7BF627D80B0A79BD1D932BAB35FA19C20770A8F830187F34831";
  level.scr_eventanim["_encstr_B19A08406FA0612F3172"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = "_encstr_BE061C26C7BF627D80B0A79BD1D932BAB35FA19C20770A8F830187F34831";
  level.scr_animtree["_encstr_BA9A080DF8502513C77A"] = #animtree;
  level.scr_anim["_encstr_BA9A080DF8502513C77A"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = % _encstr_A9261E1F2BDE9CCBFBEB50FBEF0F3A08B860CF30805FB4E91D394BD010370570;
  level.scr_animname["_encstr_BA9A080DF8502513C77A"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = "_encstr_A9261E1F2BDE9CCBFBEB50FBEF0F3A08B860CF30805FB4E91D394BD010370570";
  level.scr_eventanim["_encstr_BA9A080DF8502513C77A"]["_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A"] = "_encstr_A9261E1F2BDE9CCBFBEB50FBEF0F3A08B860CF30805FB4E91D394BD010370570";
  level.scr_animtree["_encstr_BA9A080DF8502513C77A"] = #animtree;
  level.scr_anim["_encstr_BA9A080DF8502513C77A"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = % _encstr_8AB21C203BE98DEBFB24E06837EF3357CBA34980223D2FE6F267FB55EC0F;
  level.scr_animname["_encstr_BA9A080DF8502513C77A"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = "_encstr_8AB21C203BE98DEBFB24E06837EF3357CBA34980223D2FE6F267FB55EC0F";
  level.scr_eventanim["_encstr_BA9A080DF8502513C77A"]["_encstr_8AB50C3768340C0FAE8120B73025"][0] = "_encstr_8AB21C203BE98DEBFB24E06837EF3357CBA34980223D2FE6F267FB55EC0F";
  level.scr_animtree["_encstr_BA9A080DF8502513C77A"] = #animtree;
  level.scr_anim["_encstr_BA9A080DF8502513C77A"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = % _encstr_824C1C4F2110DACDD0237D057EB0F282DDB9379BF7A0B2AF7A2EF70B5178;
  level.scr_animname["_encstr_BA9A080DF8502513C77A"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = "_encstr_824C1C4F2110DACDD0237D057EB0F282DDB9379BF7A0B2AF7A2EF70B5178";
  level.scr_eventanim["_encstr_BA9A080DF8502513C77A"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = "_encstr_824C1C4F2110DACDD0237D057EB0F282DDB9379BF7A0B2AF7A2EF70B5178";
  level.scr_animtree["_encstr_8B880DFAA82963324D26E91BF7D72A"] = #animtree;
  level.scr_anim["_encstr_8B880DFAA82963324D26E91BF7D72A"]["_encstr_81ED0F8536C499C0D758C10727DB2CC60D"] = % _encstr_A76C1F1B1CF533BA36477BB9F576C9BD57C17D07D816DC59BE85073827DE2C6C0D;
  level.scr_animname["_encstr_8B880DFAA82963324D26E91BF7D72A"]["_encstr_81ED0F8536C499C0D758C10727DB2CC60D"] = "_encstr_A76C1F1B1CF533BA36477BB9F576C9BD57C17D07D816DC59BE85073827DE2C6C0D";
  level.scr_animtree["_encstr_8B880DFAA82963324D26E91BF7D72A"] = #animtree;
  level.scr_anim["_encstr_8B880DFAA82963324D26E91BF7D72A"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = % _encstr_91081B378039D85D539B38CD312796D8CBF8C789341E40AD77A213E99A;
  level.scr_animname["_encstr_8B880DFAA82963324D26E91BF7D72A"]["_encstr_8D500CE2F76B43E81DDFF9BC3323"] = "_encstr_91081B378039D85D539B38CD312796D8CBF8C789341E40AD77A213E99A";
  scripts\engine\utility::flag_init("_encstr_88DE18BDBD10EB37900F2F68126E612F11283B0AC01F8F638019");
}

anim_fulton_exfil_player_scene(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.origin = var_4.origin;
    var_0.angles = var_4.angles;
  }

  var_5 = 0.2;
  var_6 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_1, "_encstr_8B75083B2D59F08D6337" + var_2, 1, 1, 1);
  var_7 = _id_1355A(var_0, var_1, "_encstr_8B75083B2D59F08D6337" + var_2);
  var_8 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_7, "_encstr_A71907F89A72BB1B07" + var_2);
  var_8 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  var_8 thread autoapplyquest(var_0, var_8, var_2, var_5);
  var_8 baloon_deposit_death_check("_encstr_8F7A06C32D022706" + var_2);
  var_6 ballowexecutions(var_8, var_2);
  var_6 baloon_deposit_death_check("_encstr_8B75083B2D59F08D6337" + var_2);
  var_0 scripts\cp_mp\anim_scene::anim_scene([var_6], "_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A", 1, 0, undefined, var_5);

  if(!scripts\engine\utility::flag("_encstr_88DE18BDBD10EB37900F2F68126E612F11283B0AC01F8F638019")) {
    var_0 thread scripts\cp_mp\anim_scene::anim_scene_loop([var_6, var_8], "_encstr_8AB50C3768340C0FAE8120B73025", 0, 0, undefined, var_5);
    player_cam_enable(var_1);
    level waittill("_encstr_B8F61BDFA7FA2568467399D6DF25385D823B2F6B5383EEE0630B2DA8C5");
  }

  var_0 scripts\cp_mp\anim_scene::anim_scene_stop();
  waitframe();
  scripts\engine\utility::flag_wait("_encstr_88DE18BDBD10EB37900F2F68126E612F11283B0AC01F8F638019");
  _id_12472(var_1);
  var_0 scripts\cp_mp\anim_scene::anim_scene_stop();
  level notify("_encstr_AC451A1F3D32D3F67EC768A0479E0E13ABE61E30938AA7F9348B3868");
}

player_cam_enable(var_0) {
  if(!scripts\engine\utility::flag("_encstr_88DE18BDBD10EB37900F2F68126E612F11283B0AC01F8F638019")) {
    var_0 cameraset("_encstr_ADC71F81B69DD8CEEA7FCFFBD7639850178D2B39DCEC51A72153DFFDA79AD020C5");
    var_0.gasmask_resist = 1;
  }
}

_id_12472(var_0) {
  if(istrue(var_0.gasmask_resist))
    var_0 cameradefault();
}

_id_13559(var_0, var_1) {
  if(isDefined(level.playerstartrecondronewait)) {
    return;
  }
  level.playerstartrecondronewait = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin - (0, 0, 2000));
  level.playerstartrecondronewait setModel("_encstr_A2631FB45A529979FFC38AD1A78BCB79A143F14846614917EFB297A957CD16E34D");
  level.playerstartrecondronewait.angles = var_0.angles;
  level.playerstartrecondronewait.animname = "_encstr_8B880DFAA82963324D26E91BF7D72A";
  level.playerstartrecondronewait useanimtree(level.scr_animtree["_encstr_8B880DFAA82963324D26E91BF7D72A"]);
  level.playerstartrecondronewait hide();
  level.playerstartrecondronewait playLoopSound("_encstr_BD6616AB57C2CEEDB22218201A08DFE1B3E7AF08DB0EBB91");
  return level.playerstartrecondronewait;
}

_id_123BE(var_0) {
  level thread listen_for_emp_drone_ent(var_0);
  var_1 = 7;
  wait(var_0 - var_1);
  level notify("_encstr_888E16C6DBDCD14B73D595F533D5D81DBD377DB01BC46681");
}

_id_123BF(var_0, var_1, var_2, var_3) {
  level waittill("_encstr_888E16C6DBDCD14B73D595F533D5D81DBD377DB01BC46681");

  if(istrue(level._id_12461)) {
    return;
  }
  level._id_12461 = 1;
  var_3 dontinterpolate();
  var_3 show();
  var_0 scripts\cp_mp\anim_scene::anim_scene([var_2], "_encstr_81ED0F8536C499C0D758C10727DB2CC60D", undefined, undefined, undefined, 0, 0);
  scripts\engine\utility::flag_set("_encstr_88DE18BDBD10EB37900F2F68126E612F11283B0AC01F8F638019");
  level notify("_encstr_B8F61BDFA7FA2568467399D6DF25385D823B2F6B5383EEE0630B2DA8C5");
}

_id_1355A(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_3 setModel("_encstr_A78A15ADA58D4B1D169C2FF59957C6D1ED9B7D9CDE1C56");
  var_3.angles = var_0.angles;
  var_3.animname = "_encstr_B24606B378AF0F42";
  var_3 useanimtree(level.scr_animtree[var_2]);
  waitframe();
  return var_3;
}

autoapplyquest(var_0, var_1, var_2, var_3) {
  var_0 scripts\cp_mp\anim_scene::anim_scene([var_1], "_encstr_81A30E6EE36813AF20F6A2DAD88A9F4A", 1, 0);
}

track_fulton_uses() {
  level endon("_encstr_B8F61BDFA7FA2568467399D6DF25385D823B2F6B5383EEE0630B2DA8C5");

  for(;;) {
    level waittill("_encstr_9A1C14838DB05ECA27AF5DB9CA91D72BC3E84EB0C68E", var_0);
    level.fulton_last_usetime = gettime();
  }
}

player_used_fulton_recently() {
  if(isDefined(level.fulton_last_usetime)) {
    if(gettime() > level.fulton_last_usetime + 4000)
      return 0;
    else
      return 1;
  }

  return 0;
}