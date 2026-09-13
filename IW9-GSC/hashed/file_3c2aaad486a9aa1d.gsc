/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3c2aaad486a9aa1d.gsc
***********************************************/

main() {
  _id_58954FE584B241FB = getEntArray("elevator_body", "targetname");

  foreach(part in _id_58954FE584B241FB) {
    if(isstartstr(part.model, "character"))
      part delete();
  }

  setdvarifuninitialized("dvar_D9E4F39BEB319B07", 0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("spawning", "early_complete_notify", ::_id_29740F4EC0A42E57);
  scripts\engine\utility::flag_wait("level_ready_for_script");
  thread _id_D853B7811F905161();
  _id_11811C954BBA79E3::_id_96AF355B94EFBC32();
  thread _id_ECBD2EA8830F03DC();
  _id_BD9F62EE9D50A8FB(1);
  _id_03A246920C9288C4::trophy_init();
  register_spawn_modules();
  level._id_C36C08704A4D3B97 = spawnStruct();
  _id_B7C2EAD7F1429B4A = scripts\engine\utility::getStruct("elevator_origin", "targetname");
  _id_7DE3208DDC47D267 = scripts\engine\utility::getStruct("elevator_top_origin", "targetname");
  level._id_C36C08704A4D3B97._id_3027D2806F8B9648 = _id_B7C2EAD7F1429B4A.origin;
  level._id_C36C08704A4D3B97._id_C93B1563BD093942 = _id_7DE3208DDC47D267.origin;
  level._id_C36C08704A4D3B97._id_811DC7CFCFD29886 = _id_7DE3208DDC47D267.origin[2] - _id_B7C2EAD7F1429B4A.origin[2];
  level._id_C36C08704A4D3B97.ent = scripts\engine\utility::spawn_script_origin(_id_B7C2EAD7F1429B4A.origin);

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
    level._id_C36C08704A4D3B97._id_2F10825BA72AADD1 = 25;
  else
    level._id_C36C08704A4D3B97._id_2F10825BA72AADD1 = 23;

  level._id_C36C08704A4D3B97.moving = 0;
  level._id_C36C08704A4D3B97._id_DEE9F87BDE5FC5EF = 0;
  level._id_C36C08704A4D3B97._id_944FF926630F4A0F = 0;
  level._id_C36C08704A4D3B97._id_FADA5AACD1C05046 = 0;
  level._id_C36C08704A4D3B97._id_70D316467FB1733B = 0;
  scripts\engine\utility::flag_wait("3man_door_elevator_door_open");
  _id_11811C954BBA79E3::_id_4313B6240AAB102E();
  thread _id_11811C954BBA79E3::_id_A42ED29F372BEE6B();
  _id_BD9F62EE9D50A8FB(0);
  level thread _id_AE4DF663EA752520("hadir_elevator_lock_doors");
  level thread _id_AE4DF663EA752520("elevator_fake_spawn_door");
  level notify("kill_firebarrel_threads");
  scripts\engine\scriptable::scriptable_adddamagedcallback(::_id_9549C6EF5C666DFE);
  level._id_EF0F2E9F39B9E2F8 = ::_id_EF0F2E9F39B9E2F8;
  level thread _id_E38BA6BA9E3DC3E8();
  thread _id_A85A3BB76B2DE00D();
  thread _id_A85A3BB76B2DE00D(1);
  _id_1D894DD8F9B99CFA();

  if(getdvarint("dvar_66046B8EBAD89A67", 0)) {
    foreach(_id_BE31E8030AEAE176 in getEntArray("buzzsaw", "targetname"))
    _id_230C7BB3F08D2D78::_id_B0CA36875BE60C39(_id_BE31E8030AEAE176, 1);
  }

  thread _id_1AC6D1A0FB784F18();
}

_id_D853B7811F905161() {
  level endon("game_ended");
  level endon("hadir_spawned");
  trigger = getEnt("start_elevator_hack", "targetname");

  if(isDefined(trigger)) {
    for(;;) {
      trigger waittill("trigger", player);

      if(scripts\engine\utility::flag("hadir_elevator_start")) {
        return;
      }
      if(isDefined(player) && player scripts\cp\utility::is_valid_player()) {
        if(!isDefined(level.hadir)) {
          thread scripts\cp\cp_objectives::run_objective("start_elevator");
          return;
        }
      }
    }
  }
}

_id_FA69F821120A66BA() {}

_id_BD9F62EE9D50A8FB(_id_42EB518A4127A91B) {
  clip = getEnt("defend_hallway_door_clip", "targetname");

  if(isDefined(clip)) {
    if(istrue(_id_42EB518A4127A91B))
      clip hide();
    else
      clip show();
  }
}

_id_B01F8398E11978E0() {
  _id_B9046C5883D9B4F9 = getEntArray("floor_8_doors", "script_noteworthy");

  if(isDefined(_id_B9046C5883D9B4F9) && _id_B9046C5883D9B4F9.size > 0) {
    foreach(clip in _id_B9046C5883D9B4F9) {
      if(isDefined(clip.targetname) && clip.targetname == "floor_8_door_b")
        value = "2man_elevator_gauntlet_door_b";
      else
        value = "2man_elevator_gauntlet_door_a";

      door = getEnt(value, "script_noteworthy");

      if(isDefined(door))
        clip linkTo(door);
    }
  }
}

register_spawn_modules() {
  thread _id_18A73A64992DD07D::registerambientgroup("hadir_spawn", 1, 1, 1, undefined, undefined, "hadir_spawn", ::_id_7E8D257E201538AA, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("hadir_spawn", ::_id_2D3F1BC8D5D60978);
  thread _id_18A73A64992DD07D::registerambientgroup("hadir_spawn_wounded", 1, 1, 1, undefined, undefined, "hadir_wounded_pos", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("hadir_spawn_wounded", ::_id_E843F233044BE159);
  _id_31788112DC167A12();
  _id_5A07970DA727D1E6();
}

_id_7E8D257E201538AA(_id_F8E5E3AA5762A8E7) {
  if(isDefined(level.hadir))
    _id_18A73A64992DD07D::stop_module_by_groupname(_id_F8E5E3AA5762A8E7.group_name);
}

_id_A31A43AA7379180B() {
  self waittill("death");
}

_id_31788112DC167A12() {
  _id_C0DC5AE56424ED58 = [::_id_7855F9517768ED15, 15];
  wait 3;
  thread _id_18A73A64992DD07D::registerambientgroup("elevator_defend_wave1_trophy", 1, 1, 1, undefined, undefined, "elevator_defend_ground_trophy_mid", undefined, "elevator_defend_wave1", undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("elevator_defend_wave1", 0, 4, 9, [::_id_77493DE775C92ACE, 0.5, 1], undefined, "elevator_defend_ground", [::_id_C91DEF82FAF5EB74, "elevator_defend_wave2_trophy", 50, "wave1_complete"], undefined, undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("elevator_defend_wave1", 0, 1, 1, undefined, undefined, "elevator_defend_shotgun", undefined, undefined, undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("elevator_defend_wave1", 0, 1, 1, undefined, undefined, "elevator_defend_riotshield", undefined, undefined, undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("elevator_defend_wave1", 0, 1, 1, undefined, undefined, "elevator_defend_ground_t3", undefined, undefined, undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("elevator_defend_wave2_trophy", 2, 2, 2, undefined, undefined, ["elevator_defend_ground_trophy_left", "elevator_defend_ground_trophy_right"], undefined, "elevator_defend_wave2", undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("elevator_defend_wave2", 0, 6, 9, [::_id_77493DE775C92ACE, 0.5, 2], undefined, "elevator_defend_ground", [::_id_C91DEF82FAF5EB74, "elevator_defend_wave3_trophy", 50, "wave2_complete"], "elevator_defend_wave2_pyro", undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("elevator_defend_wave2", 0, 1, 2, undefined, undefined, "elevator_defend_ground_t3", undefined, undefined, undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("elevator_defend_wave2_pyro", 0, 1, 2, 30, undefined, "elevator_defend_pyro", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("elevator_defend_wave2_pyro", ::_id_A5104D725C69532C);
  thread _id_18A73A64992DD07D::registerambientgroup("elevator_defend_wave3_trophy", 3, 3, 3, undefined, undefined, ["elevator_defend_ground_trophy_left", "elevator_defend_ground_trophy_mid", "elevator_defend_ground_trophy_right"], undefined, "elevator_defend_wave3", undefined);

  if(!getdvarint("dvar_39305D94BB610391", 0))
    thread _id_18A73A64992DD07D::registerambientgroup("elevator_defend_wave3", 0, 7, 9, [::_id_77493DE775C92ACE, 0.5, 2], undefined, "elevator_defend_ground", [::_id_C91DEF82FAF5EB74, "elevator_defend_jugg_finale_1", 60, "wave3_complete"], undefined, undefined);
  else {
    thread _id_18A73A64992DD07D::registerambientgroup("elevator_defend_wave3", 0, 7, 9, [::_id_77493DE775C92ACE, 0.5, 2], undefined, "elevator_defend_ground", ::_id_8BB75A83305F01B2, undefined, undefined);
    scripts\cp\cp_spawning_util::register_module_init_func("elevator_defend_wave3", [::_id_90850300C68AC16C, "wave3_complete"]);
  }

  thread _id_18A73A64992DD07D::registerambientgroup("elevator_defend_wave3", 0, 1, 1, undefined, undefined, "elevator_defend_shotgun", undefined, "elevator_defend_wave3_jugg", undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("elevator_defend_wave3", 0, 1, 1, undefined, undefined, "elevator_defend_riotshield", undefined, undefined, undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("elevator_defend_wave3", 0, 1, 2, undefined, undefined, "elevator_defend_ground_t3", undefined, undefined, undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("elevator_defend_wave3_jugg", 0, 2, 2, 30, undefined, "elevator_defend_jugg", _id_C0DC5AE56424ED58, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("elevator_defend_wave3_jugg", ::_id_A5104D725C69532C);
  thread _id_18A73A64992DD07D::registerambientgroup("elevator_defend_jugg_finale_1", 0, 2, 3, undefined, undefined, "elevator_defend_jugg", undefined, "elevator_defend_jugg_finale_2", undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("elevator_defend_jugg_finale_1", 0, 1, 1, undefined, undefined, "elevator_defend_velikan", undefined, undefined, undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("elevator_defend_jugg_finale_2", 0, 2, 4, undefined, undefined, "elevator_defend_jugg", undefined, ::_id_A8CF9D551B2AD144, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("elevator_defend_jugg_finale_1", ::_id_A5104D725C69532C);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("elevator_defend_jugg_finale_2", ::_id_A5104D725C69532C);
  scripts\cp\cp_spawning_util::register_module_init_func("elevator_defend_wave1_trophy", [::_id_E55E8C6B20950127, "scripted_smoke_grenade", "smoke_grenade_mp", 5]);
  scripts\cp\cp_spawning_util::register_module_init_func("elevator_defend_wave2_trophy", [::_id_E55E8C6B20950127, "scripted_smoke_grenade", "smoke_grenade_mp"]);
  scripts\cp\cp_spawning_util::register_module_init_func("elevator_defend_wave3_trophy", [::_id_E55E8C6B20950127, "scripted_smoke_grenade", "smoke_grenade_mp"]);
  scripts\cp\cp_spawning_util::register_module_init_func("elevator_defend_jugg_finale_1", [::_id_5BE4C8CB389B03BC, "finale_smoke_loc"]);

  if(!getdvarint("dvar_61117D742A43575F", 1))
    scripts\cp\cp_spawning_util::register_module_init_func("elevator_defend_wave3_trophy", [::_id_E55E8C6B20950127, "elevator_defend_flashbang", "flash_grenade_mp"]);

  if(!getdvarint("dvar_4633E0CC12321AE4", 0)) {
    _id_18A73A64992DD07D::register_module_ai_spawn_func("elevator_defend_wave1_trophy", ::_id_A45558BC281B1CDF);
    _id_18A73A64992DD07D::register_module_ai_spawn_func("elevator_defend_wave2_trophy", ::_id_A45558BC281B1CDF);
  }

  _id_18A73A64992DD07D::register_module_ai_spawn_func("elevator_defend_wave3_jugg", ::_id_DEEE0A0E934A0315);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("elevator_defend_wave1_trophy", ::_id_DEEE0A0E934A0315);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("elevator_defend_wave1", ::_id_DEEE0A0E934A0315);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("elevator_defend_wave2_trophy", ::_id_DEEE0A0E934A0315);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("elevator_defend_wave2", ::_id_DEEE0A0E934A0315);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("elevator_defend_wave2_pyro", ::_id_DEEE0A0E934A0315);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("elevator_defend_wave3_trophy", ::_id_DEEE0A0E934A0315);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("elevator_defend_wave3", ::_id_DEEE0A0E934A0315);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("elevator_defend_wave3_jugg", ::_id_DEEE0A0E934A0315);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("elevator_defend_jugg_finale_1", ::_id_DEEE0A0E934A0315);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("elevator_defend_jugg_finale_2", ::_id_DEEE0A0E934A0315);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("elevator_defend_jugg_finale_1", ::_id_3DBF2E06F4F22FCE);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("elevator_defend_jugg_finale_2", ::_id_3DBF2E06F4F22FCE);
}

_id_5A07970DA727D1E6() {
  _id_8D282F818B516EE4 = [::_id_7855F9517768ED15, 2];
  _id_8D2830818B517117 = [::_id_7855F9517768ED15, 3];
  _id_C0DC5FE56424F857 = [::_id_7855F9517768ED15, 10];
  thread _id_18A73A64992DD07D::registerambientgroup("floor_7_ascender", 0, 3, 3, undefined, undefined, "floor_7_ascender", _id_8D2830818B517117, "floor_7_group_2", undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("floor_7_group_2", 0, 4, 4, undefined, undefined, "floor_7_group_2", _id_8D2830818B517117, undefined, undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("floor_8_trigger_ai", 0, 5, 5, undefined, undefined, "floor_8_trigger_ai", undefined, undefined, undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("floor_8_trigger_ai_2", 0, 3, 3, undefined, undefined, "floor_8_trigger_ai_2", undefined, undefined, undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("floor_8_trigger_ai_3", 0, 6, 6, undefined, undefined, "floor_8_trigger_ai_3", undefined, undefined, undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("floor_7_group_3", 0, 4, 4, undefined, undefined, "floor_7_group_3", undefined, undefined, undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("floor_7_group_4", 0, 4, 4, undefined, undefined, "floor_7_group_4", undefined, undefined, undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("floor_7_group_5", 1, 1, 1, undefined, undefined, "floor_7_group_5_riotshield", undefined, "floor_7_group_5a", undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("floor_7_group_5a", 0, 3, 3, undefined, undefined, "floor_7_group_5", ::_id_7855F9517768ED15, undefined, undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("floor_7_stairs", 0, 2, 2, undefined, undefined, "floor_7_stairs", undefined, undefined, undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("floor_8_stairs", 0, 2, 2, undefined, undefined, "floor_8_stairs", undefined, undefined, undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("ascender_attack_floor_9", 0, 6, 6, undefined, undefined, "ascender_attack_floor_9", undefined, undefined, undefined);
  scripts\cp\cp_spawning_util::register_module_init_func("floor_7_ascender", ::_id_E1E9C9BE2AA1C067);
}

_id_4B6394B60FF8E39F() {
  thread _id_18A73A64992DD07D::registerambientgroup("elevator_defend_pyro", 0, 1, 1, undefined, undefined, "elevator_defend_pyro", undefined, undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("elevator_defend_jugg", 0, 1, 1, undefined, undefined, "elevator_defend_jugg", undefined, undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("elevator_defend_riotshield", 0, 1, 1, undefined, undefined, "elevator_defend_riotshield", undefined, undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("elevator_defend_tests", 1, 1, undefined, undefined, undefined, "elevator_defend_tests", undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("elevator_defend_tests", ::_id_DEEE0A0E934A0315);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("elevator_defend_pyro", ::_id_A5104D725C69532C);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("elevator_defend_jugg", ::_id_A5104D725C69532C);
  thread _id_18A73A64992DD07D::registerambientgroup("jugg_parade_test_1", 0, 2, 3, undefined, undefined, "elevator_defend_jugg", undefined, "jugg_parade_test_2", undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("jugg_parade_test_1", 0, 1, 1, undefined, undefined, "elevator_defend_velikan", undefined, undefined, undefined);
  thread _id_18A73A64992DD07D::registerambientgroup("jugg_parade_test_2", 0, 2, 4, undefined, undefined, "elevator_defend_jugg", ::_id_8BB75A83305F01B2, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("jugg_parade_test_1", ::_id_A5104D725C69532C);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("jugg_parade_test_2", ::_id_A5104D725C69532C);
  scripts\cp\cp_spawning_util::register_module_init_func("jugg_parade_test_1", [::_id_E55E8C6B20950127, ["scripted_smoke_grenade", "jugg_parade_smoke"], "smoke_grenade_mp", 3]);
  scripts\cp\cp_spawning_util::register_module_init_func("jugg_parade_test_2", [::_id_E55E8C6B20950127, ["scripted_smoke_grenade", "jugg_parade_smoke"], "smoke_grenade_mp", 3]);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("jugg_parade_test_1", ::_id_DEEE0A0E934A0315);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("jugg_parade_test_2", ::_id_DEEE0A0E934A0315);
}

_id_DEEE0A0E934A0315(_id_F8E5E3AA5762A8E7) {
  if(isDefined(self.spawner.target)) {
    struct = scripts\engine\utility::getStruct(self.spawner.target, "targetname");
    doors = getentitylessscriptablearray(undefined, undefined, struct.origin, 128, "door");

    if(isDefined(doors) && doors.size > 0) {
      foreach(door in doors)
      door thread _id_AC506E3BED9D6FBF(self);
    }
  }
}

_id_3DBF2E06F4F22FCE(_id_F8E5E3AA5762A8E7) {
  level thread _id_BFD8B6C9607658DA();
}

_id_BFD8B6C9607658DA() {
  level endon("game_ended");

  if(istrue(level._id_0377085AE3406637)) {
    return;
  }
  level thread _id_05227F6FD5F77102();
}

_id_05227F6FD5F77102() {
  level endon("game_ended");
  level._id_0377085AE3406637 = 1;
  setmusicstate("mx_cp_jugg_maze_tier2_found");
}

_id_A5104D725C69532C(_id_F8E5E3AA5762A8E7) {
  self._id_CED8415AAAD3FF6D = 1;

  if(scripts\cp\utility::isjuggernaut())
    thread _id_11811C954BBA79E3::_id_93ABDD2400A0A3E0();
}

_id_7855F9517768ED15(_id_F8E5E3AA5762A8E7, delay) {
  if(!isDefined(delay))
    delay = 5;

  wait(delay);
}

_id_90850300C68AC16C(_id_F8E5E3AA5762A8E7, flag) {
  scripts\engine\utility::flag_set(flag);
}

_id_7628F64809E763CB(_id_18041D0638A909B7, _id_5D825B291EEF6A58) {
  wait(_id_18041D0638A909B7);

  foreach(player in level.players) {
    if(distance(player getEye(), _id_5D825B291EEF6A58) < 500)
      result = _id_74502A9E0EF1F19C::applyflashfromdamage(player, self, _id_5D825B291EEF6A58, 0);
  }
}

_id_5BE4C8CB389B03BC(_id_F8E5E3AA5762A8E7, targetname) {
  thread _id_5A99AF893C9F7374(_id_F8E5E3AA5762A8E7, targetname);
}

_id_5A99AF893C9F7374(_id_F8E5E3AA5762A8E7, targetname) {
  level endon("elevator_defend_completed");
  level endon("game_ended");
  _id_9577902B42FBD7F6 = scripts\engine\utility::getStructArray(targetname, "targetname");
  vfx = scripts\engine\utility::getfx("vfx_cp_raid_elevator_room_smoke");

  for(;;) {
    foreach(loc in _id_9577902B42FBD7F6)
    playFX(vfx, loc.origin);

    wait 7;
  }
}

_id_E55E8C6B20950127(_id_F8E5E3AA5762A8E7, targetname, _id_A664AAD02EE98BD2, delay) {
  thread _id_601505C22676FD69(_id_F8E5E3AA5762A8E7, targetname, _id_A664AAD02EE98BD2, delay);
}

_id_601505C22676FD69(_id_F8E5E3AA5762A8E7, targetname, _id_A664AAD02EE98BD2, delay) {
  if(isarray(targetname)) {
    targets = [];

    foreach(name in targetname) {
      _id_055F75D9F16D814F = scripts\engine\utility::getStructArray(name, "targetname");
      targets = scripts\engine\utility::array_combine(targets, _id_055F75D9F16D814F);
    }
  } else
    targets = scripts\engine\utility::getStructArray(targetname, "targetname");

  foreach(target in targets) {
    if(_id_A664AAD02EE98BD2 == "flash_grenade_mp") {
      grenade = magicgrenademanual(_id_A664AAD02EE98BD2, target.origin + (0, 0, 90), (0, 0, -10), 0.5);
      grenade.team = "axis";
      grenade thread _id_7628F64809E763CB(0.5, grenade.origin);
      continue;
    }

    if(_id_A664AAD02EE98BD2 == "smoke_grenade_mp")
      thread _id_666AD13B45A9EBCD(_id_A664AAD02EE98BD2, target);
  }

  if(isDefined(delay))
    wait(delay);
}

_id_666AD13B45A9EBCD(_id_A664AAD02EE98BD2, target) {
  if(target scripts\engine\utility::ent_flag_exist("ready_for_smoke"))
    target scripts\engine\utility::ent_flag_wait("ready_for_smoke");

  grenade = magicgrenademanual(_id_A664AAD02EE98BD2, target.origin + (0, 0, 90), (0, 0, -10), 0.5);
  grenade.team = "axis";
  grenade thread _id_74502A9E0EF1F19C::smokegrenadeused();
  target scripts\engine\utility::ent_flag_clear("ready_for_smoke");
}

_id_9549C6EF5C666DFE(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  if(isDefined(instance.type) && instance.type == "decor_barrels_gameplay_flammable_noent") {
    if(!istrue(instance._id_AEB4F8752F85C5F1))
      _id_65832DD108A7C558(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname);
  }
}

_id_A85A3BB76B2DE00D(_id_50F9C5A279023BC2) {
  level._id_168F04BC9AFCFAAC = 1;
  data = spawnStruct();
  _id_FEF7FF29C1843069 = undefined;

  if(!istrue(_id_50F9C5A279023BC2))
    _id_FEF7FF29C1843069 = getEnt("2man_elevator_gauntlet_door_a", "script_noteworthy");
  else
    _id_FEF7FF29C1843069 = getEnt("2man_elevator_gauntlet_door_b", "script_noteworthy");

  if(!isDefined(_id_FEF7FF29C1843069.script_offset))
    _id_FEF7FF29C1843069.script_offset = (-50, 0, 0);

  _id_5AC49E018B46B2CD = undefined;
  _id_20F3271DC43A6012 = undefined;

  if(!istrue(_id_50F9C5A279023BC2)) {
    _id_5AC49E018B46B2CD = scripts\engine\utility::getStruct("2man_gauntlet_blocker_button", "targetname");
    _id_5AC49E018B46B2CD scripts\cp\cp_juggernaut::_id_91ED8C25C9B88686();
    _id_20F3271DC43A6012 = scripts\engine\utility::getStruct("2man_gauntlet_return_button", "targetname");
    _id_20F3271DC43A6012 scripts\cp\cp_juggernaut::_id_91ED8C25C9B88686();
  } else {
    _id_5AC49E018B46B2CD = scripts\engine\utility::getStruct("2man_gauntlet_blocker_button_2", "targetname");
    _id_5AC49E018B46B2CD scripts\cp\cp_juggernaut::_id_91ED8C25C9B88686();
    _id_20F3271DC43A6012 = scripts\engine\utility::getStruct("2man_gauntlet_return_button_2", "targetname");
    _id_20F3271DC43A6012 scripts\cp\cp_juggernaut::_id_91ED8C25C9B88686();
  }

  _id_5AC49E018B46B2CD.origin = _id_5AC49E018B46B2CD.origin + rotatevector((0, 0, 0.25), _id_5AC49E018B46B2CD.angles);
  _id_20F3271DC43A6012.origin = _id_20F3271DC43A6012.origin + rotatevector((0, 0, 0.25), _id_20F3271DC43A6012.angles);
  _id_FEF7FF29C1843069.target = _id_5AC49E018B46B2CD.targetname;
  hintstring = &"CP_RAID_WATERMAZE/DOOR_OPEN";
  _id_5AC49E018B46B2CD _id_34D2771929BD6022::_id_2FECC1AAB1890E7D(hintstring, "tag_origin", 64, 256, "duration_none", "hide");
  _id_20F3271DC43A6012 _id_34D2771929BD6022::_id_2FECC1AAB1890E7D(hintstring, "tag_origin", 64, 256, "duration_none", "hide");
  _id_34D2771929BD6022::_id_05F7C6BF2110C0FE(_id_FEF7FF29C1843069, undefined, undefined, undefined, 1);
  _id_FEF7FF29C1843069 thread _id_C093C2F3D1CFEE0B();
}

_id_C093C2F3D1CFEE0B() {
  level endon("game_ended");
  self notify("puzzle_doors_sound_watchfornotify");
  self endon("puzzle_doors_sound_watchfornotify");

  for(;;) {
    scripts\engine\utility::waittill_any_2("door_open", "door_close");
    thread scripts\cp\utility::playsoundatpos_safe(self.origin, "cp_puzzledoor_open");
  }
}

_id_65832DD108A7C558(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  level endon("game_ended");
  instance._id_AEB4F8752F85C5F1 = 1;

  while(instance getscriptablepartstate("base") != "death")
    wait 0.05;

  _id_35BBF066F50AC582 = 206;
  attacker = undefined;

  if(isDefined(instance.lastattacker))
    attacker = instance.lastattacker;

  radiusdamage(instance.origin, _id_35BBF066F50AC582, 666, 333, attacker, "MOD_EXPLOSIVE", "molotov_mp");
}

_id_29740F4EC0A42E57(_id_F8E5E3AA5762A8E7) {
  totalspawns = _id_18A73A64992DD07D::process_module_var(_id_F8E5E3AA5762A8E7, _id_F8E5E3AA5762A8E7.totalspawns);
  _id_F8E5E3AA5762A8E7.debug_data.totalspawns = totalspawns;

  if(totalspawns > 0 && _id_F8E5E3AA5762A8E7 _id_18A73A64992DD07D::get_activecount_from_group(1) + _id_F8E5E3AA5762A8E7.currentmodulekills >= totalspawns) {
    level notify("spawn_module_" + _id_F8E5E3AA5762A8E7.moduleid + "_completed");
    return;
  }
}

_id_1B4FABA836C0F200() {
  _id_3B64EB40368C1450::set("elevator_defend", "ascender_use", 0);
  ascenders = getentitylessscriptablearray("scriptable_military_ascendertop_heavy", "classname");

  foreach(ascender in ascenders)
  _id_18AF78602B67B70C::_id_F1BB8A269D750F18(0, ascender);

  _id_47B79FF87B0FA03F = getEntArray("ascender_path_a_rope", "targetname");

  foreach(_id_4B6F93B6C76155B6 in _id_47B79FF87B0FA03F) {
    if(isDefined(_id_4B6F93B6C76155B6))
      _id_4B6F93B6C76155B6 delete();
  }
}

_id_8091A29AB763E925(_id_41D8BF229CF29051, locationorigin, radius) {
  if(!isDefined(radius))
    radius = 128;

  _id_5C93411D5E143956 = getentitylessscriptablearray("military_ascendertop_heavy", "classname");
  _id_DD156FF0EEBD118E = getentitylessscriptablearray("elevator_descend_start", "targetname");
  _id_B82724CDD7191C5C = scripts\cp\utility::array_merge(_id_5C93411D5E143956, _id_DD156FF0EEBD118E);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B82724CDD7191C5C.size; _id_AC0E594AC96AA3A8++) {
    if(distance2d(_id_B82724CDD7191C5C[_id_AC0E594AC96AA3A8].origin, locationorigin) <= radius)
      _id_F1BB8A269D750F18(_id_41D8BF229CF29051, _id_B82724CDD7191C5C[_id_AC0E594AC96AA3A8]);
  }
}

_id_F1BB8A269D750F18(_id_41D8BF229CF29051, scriptable) {
  if(istrue(_id_41D8BF229CF29051)) {
    foreach(player in level.players)
    scriptable enablescriptableplayeruse(player);
  } else {
    foreach(player in level.players)
    scriptable disablescriptableplayeruse(player);
  }
}

_id_77493DE775C92ACE(_id_F8E5E3AA5762A8E7, min_delay, max_delay) {
  return randomfloatrange(min_delay, max_delay);
}

_id_AE4DF663EA752520(_id_AF32772A333EC8D7) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("3man_door_elevator_door_open");
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray(_id_AF32772A333EC8D7, "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_9E4E1482CB40C9C5.size; _id_AC0E594AC96AA3A8++) {
    doors = getentitylessscriptablearray(undefined, undefined, _id_9E4E1482CB40C9C5[_id_AC0E594AC96AA3A8].origin, 128, "door");

    foreach(door in doors)
    door thread _id_DFD5D67FD657BF7B();
  }
}

_id_AC506E3BED9D6FBF(ai) {
  if(self scriptabledoorisclosed()) {
    self notify("door_openDoorThreaded");
    self endon("door_openDoorThreaded");
    level endon("game_ended");
    self _meth_80902296B05BE00A(1);
    count = 0;

    while(self scriptabledoorisclosed()) {
      wait 0.05;
      count++;

      if(count > 10)
        count = 0;
    }

    self.blocked = undefined;
    self._id_A16669FDD0578E00 = 1;

    for(;;) {
      if(scripts\common\utility::_id_0A92D0739B2373DF(self.origin, 600).size > 0) {
        wait 0.25;
        continue;
      }

      break;
    }

    thread _id_DFD5D67FD657BF7B();
  }
}

_id_DFD5D67FD657BF7B() {
  self setscriptablepartstate("door", "closed");
  self scriptabledoorclose(1);

  while(!self scriptabledoorisclosed())
    wait 0.05;

  self _meth_9AF4C9B2CC1BF989(1);
  self.blocked = 1;
  self._id_A16669FDD0578E00 = undefined;
}

_id_A8CF9D551B2AD144(_id_F8E5E3AA5762A8E7) {
  level thread _id_0DA164AE500C750C(_id_F8E5E3AA5762A8E7);
}

_id_0DA164AE500C750C(_id_F8E5E3AA5762A8E7) {
  level endon("game_ended");
  _id_01D4621C77C9108F = getaiarray("axis");

  for(_id_CBBFE87743C08D37 = isDefined(level.hadir) && isagent(level.hadir) && isalive(level.hadir); _id_01D4621C77C9108F.size > _id_CBBFE87743C08D37; _id_01D4621C77C9108F = getaiarray("axis"))
    wait 0.05;

  _id_AF11D57CF1D86571();
}

_id_8BB75A83305F01B2(_id_F8E5E3AA5762A8E7, _id_B50EB159982EBD81, timeout) {
  level thread _id_D85134914C62A056(_id_F8E5E3AA5762A8E7, _id_B50EB159982EBD81, timeout);
}

_id_D85134914C62A056(_id_F8E5E3AA5762A8E7, _id_B50EB159982EBD81, timeout) {
  _id_2B1B52AA6A12C599 = _id_18A73A64992DD07D::get_module_structs_by_groupname(_id_F8E5E3AA5762A8E7.group_name);
  _id_22BFE98214726B66 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2B1B52AA6A12C599.size; _id_AC0E594AC96AA3A8++)
    _id_22BFE98214726B66[_id_22BFE98214726B66.size] = "spawn_module_" + _id_2B1B52AA6A12C599[_id_AC0E594AC96AA3A8].moduleid + "_completed";

  _id_9800B4122043CC9B(_id_22BFE98214726B66, timeout, _id_F8E5E3AA5762A8E7.group_name);
  count = 100;

  while(count > 0) {
    _id_2B1B52AA6A12C599 = _id_18A73A64992DD07D::get_module_structs_by_groupname(_id_F8E5E3AA5762A8E7.group_name, 1);
    count = 0;

    foreach(_id_F564CE57BB79FF69 in _id_2B1B52AA6A12C599)
    count = count + _id_F564CE57BB79FF69 _id_18A73A64992DD07D::get_activecount_from_group(1);

    wait 0.5;
  }

  scripts\engine\utility::flag_wait_all("wave1_complete", "wave2_complete", "wave3_complete");
  _id_AF11D57CF1D86571();
}

_id_C91DEF82FAF5EB74(_id_F8E5E3AA5762A8E7, _id_B50EB159982EBD81, timeout, _id_ACBA072B7E847A86) {
  level thread _id_E803DD34F0D0DCFC(_id_F8E5E3AA5762A8E7, _id_B50EB159982EBD81, timeout, _id_ACBA072B7E847A86);
}

_id_E803DD34F0D0DCFC(_id_F8E5E3AA5762A8E7, _id_B50EB159982EBD81, timeout, _id_ACBA072B7E847A86) {
  _id_2B1B52AA6A12C599 = _id_18A73A64992DD07D::get_module_structs_by_groupname(_id_F8E5E3AA5762A8E7.group_name);
  _id_22BFE98214726B66 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2B1B52AA6A12C599.size; _id_AC0E594AC96AA3A8++)
    _id_22BFE98214726B66[_id_22BFE98214726B66.size] = "spawn_module_" + _id_2B1B52AA6A12C599[_id_AC0E594AC96AA3A8].moduleid + "_completed";

  _id_9800B4122043CC9B(_id_22BFE98214726B66, timeout, _id_F8E5E3AA5762A8E7.group_name);
  count = 100;

  while(count > 0) {
    _id_2B1B52AA6A12C599 = _id_18A73A64992DD07D::get_module_structs_by_groupname(_id_F8E5E3AA5762A8E7.group_name);
    count = 0;

    foreach(_id_F564CE57BB79FF69 in _id_2B1B52AA6A12C599)
    count = count + _id_F564CE57BB79FF69 _id_18A73A64992DD07D::get_activecount_from_group(1);

    wait 0.5;
  }

  if(isDefined(_id_ACBA072B7E847A86))
    scripts\engine\utility::flag_set(_id_ACBA072B7E847A86);

  if(isDefined(_id_B50EB159982EBD81))
    _id_18A73A64992DD07D::run_spawn_module(_id_B50EB159982EBD81);
}

_id_9800B4122043CC9B(_id_22BFE98214726B66, timeout, group_name) {
  if(isDefined(timeout)) {
    level endon(group_name + "_timeout");
    level thread _id_AFB3EF1962FF4410(timeout, group_name);
  }

  scripts\engine\utility::waittill_all_in_array(_id_22BFE98214726B66);
}

_id_AFB3EF1962FF4410(timeout, group_name) {
  level endon("game_ended");
  wait(timeout);
  level notify(group_name + "_timeout");
}

_id_A45558BC281B1CDF(_id_F8E5E3AA5762A8E7) {
  thread _id_C4E9B3D4520931D1(_id_F8E5E3AA5762A8E7);
}

_id_C4E9B3D4520931D1(_id_F8E5E3AA5762A8E7) {
  self endon("death");
  level endon("game_ended");
  self waittill("goal");
  _id_2424BA8D014C44FA = scripts\engine\utility::getStruct(self.spawner.target, "targetname");

  if(isDefined(_id_2424BA8D014C44FA) && !istrue(_id_2424BA8D014C44FA.in_use)) {
    level notify("trophy_created", _id_2424BA8D014C44FA);
    thread _id_03A246920C9288C4::_id_233602CC27D9FCF8(self, 1, 1000, 200, "axis");
    thread _id_36CD94B1BDAC56BD(_id_2424BA8D014C44FA);
  }
}

_id_36CD94B1BDAC56BD(_id_2424BA8D014C44FA) {
  self notify("free_trophy_loc_on_trophy_death");
  self endon("free_trophy_loc_on_trophy_death");

  if(isDefined(_id_2424BA8D014C44FA)) {
    level endon("game_ended");
    _id_2424BA8D014C44FA.in_use = 1;
    self.trophy waittill("death");
    _id_2424BA8D014C44FA.in_use = undefined;
  }
}

_id_E843F233044BE159(_id_F8E5E3AA5762A8E7) {
  thread _id_611F8ED89AB21247(_id_F8E5E3AA5762A8E7);
}

#using_animtree("generic_human");

_id_611F8ED89AB21247(_id_F8E5E3AA5762A8E7) {
  self endon("death");
  level endon("game_ended");
  level.hadir = self;
  self.ignoreall = 1;
  self.invulnerable = 1;
  self.position = "front";
  self.scene = "wounded";
  self.nocorpse = 1;
  self.never_kill_off = 1;
  self._id_45E0128A2FF05F04 = 1;
  animnode = scripts\engine\utility::spawn_tag_origin(self.spawner.origin, self.spawner.angles);
  waitframe();

  while(!isDefined(level._id_C36C08704A4D3B97) || !isDefined(level._id_C36C08704A4D3B97.ent))
    waitframe();

  animnode linkTo(level._id_C36C08704A4D3B97.ent);
  self linktomoveoffset(animnode, "tag_origin");
  self.animnode = animnode;
  _id_3E38EE41DC326FDC = "cp_raid4_hadir_elevator";
  animset = "caps/cp/cp_raid4_hadir_elevator";
  self.disablearrivals = 1;
  self.goalradius = 16;
  thread _id_A31A43AA7379180B();
  anime = % cap_raid_ep4_hadir_elevator_wounded_idle01;
  startorigin = getstartorigin(self.origin, self.angles, anime);
  startangles = getstartangles(self.origin, self.angles, anime);
  self setOrigin(startorigin, 1);
  self setplayerangles(startangles);
  _id_010B6724C15A95E8::_id_C434AF0895CC147C(_id_3E38EE41DC326FDC, animset, 1);

  for(;;) {
    self waittill("scene_end");
    self.scene = "wounded";
  }
}

_id_2D3F1BC8D5D60978(_id_F8E5E3AA5762A8E7) {
  thread _id_886CDDF7A24E9DA8(_id_F8E5E3AA5762A8E7);
}

_id_886CDDF7A24E9DA8(_id_F8E5E3AA5762A8E7) {
  level notify("hadir_spawned");
  level.hadir = self;
  self.ignoreall = 1;
  self.invulnerable = 1;
  self.nocorpse = 1;
  self.never_kill_off = 1;
  self.position = "front";
  self.scene = "idle";
  self.dropweapon = 0;
  self._id_AD799295A6692B29 = 0;
  self._id_0D932F46857D6D61 = undefined;
  self._id_45E0128A2FF05F04 = 1;
  animnode = scripts\engine\utility::spawn_tag_origin(self.spawner.origin, self.spawner.angles);
  waitframe();

  while(!isDefined(level._id_C36C08704A4D3B97) || !isDefined(level._id_C36C08704A4D3B97.ent))
    waitframe();

  animnode linkTo(level._id_C36C08704A4D3B97.ent);
  self linktomoveoffset(animnode, "tag_origin");
  self.animnode = animnode;
  level._id_85450637E0DC4460 = spawnStruct();
  level._id_85450637E0DC4460._id_201F3473571026F5 = getEnt("ele_light_move", "targetname");

  if(isDefined(level._id_85450637E0DC4460._id_201F3473571026F5))
    level._id_85450637E0DC4460._id_201F3473571026F5 linkTo(animnode);

  thread _id_B1FA413139716222();
  thread _id_FA69F821120A66BA();
  thread _id_A31A43AA7379180B();
  thread _id_67187B793B2AB5AD();
}

_id_67187B793B2AB5AD() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("hadir_elevator_crashed");
  wait 1;
  self kill();
}

_id_885D9AFCFC7ED133() {
  _id_3E38EE41DC326FDC = "cp_raid4_hadir_elevator";
  animset = "caps/cp/cp_raid4_hadir_elevator";
  self.disablearrivals = 1;
  self.goalradius = 16;
  anime = % cap_raid_ep4_hadir_elevator_a_01;
  startorigin = getstartorigin(self.origin, self.angles, anime);
  startangles = getstartangles(self.origin, self.angles, anime);
  self setOrigin(startorigin, 1);
  self setplayerangles(startangles);
  wait 1;
  _id_010B6724C15A95E8::_id_C434AF0895CC147C(_id_3E38EE41DC326FDC, animset, 1);
  wait 2;
  _id_FD4CA51638E981BF = [];
  _id_FD4CA51638E981BF[_id_FD4CA51638E981BF.size] = "a01";
  _id_FD4CA51638E981BF[_id_FD4CA51638E981BF.size] = "a02";
  _id_FD4CA51638E981BF[_id_FD4CA51638E981BF.size] = "b01";
  _id_FD4CA51638E981BF[_id_FD4CA51638E981BF.size] = "b02";
  _id_FD4CA51638E981BF[_id_FD4CA51638E981BF.size] = "b03";
  _id_FD4CA51638E981BF[_id_FD4CA51638E981BF.size] = "c01";
  _id_FD4CA51638E981BF[_id_FD4CA51638E981BF.size] = "c02";
  _id_FD4CA51638E981BF[_id_FD4CA51638E981BF.size] = "c03";
  _id_FD4CA51638E981BF[_id_FD4CA51638E981BF.size] = "d01";
  _id_FD4CA51638E981BF[_id_FD4CA51638E981BF.size] = "e01";
  _id_FD4CA51638E981BF[_id_FD4CA51638E981BF.size] = "f01";
  _id_FD4CA51638E981BF[_id_FD4CA51638E981BF.size] = "g01";
  _id_FD4CA51638E981BF[_id_FD4CA51638E981BF.size] = "shake01";
  _id_FD4CA51638E981BF[_id_FD4CA51638E981BF.size] = "shake02";
  _id_FD4CA51638E981BF[_id_FD4CA51638E981BF.size] = "bullet01";
  _id_FD4CA51638E981BF[_id_FD4CA51638E981BF.size] = "bullet02";
  _id_FD4CA51638E981BF[_id_FD4CA51638E981BF.size] = "fall01";
  _id_FD4CA51638E981BF[_id_FD4CA51638E981BF.size] = "fall02";
  _id_D7524FE4C297D7E9 = scripts\engine\utility::create_deck(_id_FD4CA51638E981BF, 1, 1, 1);

  for(;;) {
    _id_46BE59E416CC0790("walk_f-l");
    _id_46BE59E416CC0790(_id_D7524FE4C297D7E9 scripts\engine\utility::deck_draw());
    _id_46BE59E416CC0790("walk_l-r");
    _id_46BE59E416CC0790(_id_D7524FE4C297D7E9 scripts\engine\utility::deck_draw());
    _id_46BE59E416CC0790("walk_r-l");
    _id_46BE59E416CC0790(_id_D7524FE4C297D7E9 scripts\engine\utility::deck_draw());
    _id_46BE59E416CC0790("walk_l-f");
    _id_46BE59E416CC0790(_id_D7524FE4C297D7E9 scripts\engine\utility::deck_draw());
    _id_46BE59E416CC0790("walk_f-r");
    _id_46BE59E416CC0790(_id_D7524FE4C297D7E9 scripts\engine\utility::deck_draw());
    _id_46BE59E416CC0790("walk_r-f");
    _id_46BE59E416CC0790(_id_D7524FE4C297D7E9 scripts\engine\utility::deck_draw());
  }
}

_id_46BE59E416CC0790(_id_CA85A0DE365C6A63) {
  self.scene = _id_CA85A0DE365C6A63;

  if(issubstr(_id_CA85A0DE365C6A63, "-l"))
    self.position = "left";
  else if(issubstr(_id_CA85A0DE365C6A63, "-r"))
    self.position = "right";
  else if(issubstr(_id_CA85A0DE365C6A63, "-f"))
    self.position = "front";

  self waittill("scene_end");
}

_id_B1FA413139716222() {
  level endon("game_ended");
  level endon("hadir_elevator_crashed");
  _id_3E38EE41DC326FDC = "cp_raid4_hadir_elevator";
  animset = "caps/cp/cp_raid4_hadir_elevator";
  self.disablearrivals = 1;
  self.goalradius = 16;
  anime = % cap_raid_ep4_hadir_elevator_a_01;
  startorigin = getstartorigin(self.origin, self.angles, anime);
  startangles = getstartangles(self.origin, self.angles, anime);
  self setOrigin(startorigin, 1);
  self setplayerangles(startangles);
  wait 1;
  _id_010B6724C15A95E8::_id_C434AF0895CC147C(_id_3E38EE41DC326FDC, animset, 1);
  thread _id_2A2223F4E24D40A8();

  for(;;) {
    level waittill("change_hadir_cap_scene", _id_CA85A0DE365C6A63);
    _id_46BE59E416CC0790(_id_CA85A0DE365C6A63);
    self waittill("scene_end");
    self.scene = "idle";
    thread _id_FA69F821120A66BA();
  }
}

_id_2A2223F4E24D40A8() {
  level endon("game_ended");
  self endon("death");
  level endon("hadir_elevator_crashed");
  level thread _id_902781F104BDECAD();
  _id_720716BB29B0644B = ["a01", "a02", "b01", "b02", "b03", "c01", "c02", "c03", "d01", "e01", "f01", "g01"];

  for(;;) {
    wait(randomintrange(5, 10));

    if(istrue(level._id_256F2A4887F161B4)) {
      waitframe();
      continue;
    }

    self.scene = scripts\engine\utility::random(_id_720716BB29B0644B);
  }
}

_id_902781F104BDECAD() {
  level endon("game_ended");
  self endon("death");
  level endon("hadir_elevator_crashed");
  _id_F4DF03F7F5D54613 = ["shake01", "shake02", "bullet01", "bullet02", "fall01", "fall02"];

  for(;;) {
    level waittill("hadir_elevator_lever_destroyed");
    level._id_256F2A4887F161B4 = 1;
    self.scene = scripts\engine\utility::random(_id_F4DF03F7F5D54613);
    wait 5;
    level._id_256F2A4887F161B4 = 0;
  }
}

_id_5A99C6B1EF922EB1(_id_CA85A0DE365C6A63) {
  level notify("change_hadir_cap_scene", _id_CA85A0DE365C6A63);
}

_id_EE3A6BF661A9378D() {
  self waittill("scene_end");
}

_id_AF11D57CF1D86571(_id_F8E5E3AA5762A8E7) {
  level notify("elevator_defend_completed");
  level notify("end_ammo_restock_threads");
}

_id_690C418CFA7C35B4(_id_F8E5E3AA5762A8E7, _id_B50EB159982EBD81, timeout) {
  if(isDefined(timeout))
    _id_F8E5E3AA5762A8E7 thread _id_24B32B09A140CC4B(timeout);

  level scripts\engine\utility::waittill_either("spawn_module_" + _id_F8E5E3AA5762A8E7.moduleid + "_completed", "spawn_module_" + _id_F8E5E3AA5762A8E7.moduleid + "_timeout_reached");
  return _id_B50EB159982EBD81;
}

_id_24B32B09A140CC4B(timeout) {
  level endon("game_ended");
  self endon("death");
  wait(timeout);
  level notify("spawn_module_" + self.moduleid + "_timeout_reached");
}

_id_241A98C751F994DD() {
  _id_C8FE63AFAAA93EF0 = scripts\engine\utility::getStruct("ascender_a", "targetname");
  ascenders = getentitylessscriptablearray("scriptable_military_ascendertop_heavy", "classname", _id_C8FE63AFAAA93EF0.origin, 128);

  foreach(ascender in ascenders)
  _id_18AF78602B67B70C::_id_F1BB8A269D750F18(0, ascender);
}

_id_5528B94BD5DBAE61() {
  _id_C8FE63AFAAA93EF0 = scripts\engine\utility::getStruct("ascender_a", "targetname");
  ascenders = getentitylessscriptablearray("scriptable_military_ascendertop_heavy", "classname", _id_C8FE63AFAAA93EF0.origin, 128);

  foreach(ascender in ascenders)
  _id_18AF78602B67B70C::_id_F1BB8A269D750F18(1, ascender);
}

_id_3828D19A1D89FCAD(_id_E078EBE057850555, _id_A48690924A63CDED) {
  if(!isDefined(level._id_698B79A86753F9EA))
    level._id_698B79A86753F9EA = [];

  ent = getEnt("defend_hallway_door_clip", "targetname");
  _id_409E0E80F2171B93 = spawn("script_model", _id_E078EBE057850555 + (0, 0, 50));
  _id_409E0E80F2171B93.angles = _id_A48690924A63CDED;
  _id_409E0E80F2171B93 clonebrushmodeltoscriptmodel(ent);
  level._id_698B79A86753F9EA[level._id_698B79A86753F9EA.size] = _id_409E0E80F2171B93;
}

_id_E1E9C9BE2AA1C067(_id_F8E5E3AA5762A8E7) {
  if(isDefined(level._id_698B79A86753F9EA) && level._id_698B79A86753F9EA.size > 0) {
    foreach(ent in level._id_698B79A86753F9EA)
    ent delete();

    level._id_698B79A86753F9EA = [];
  }
}

_id_1AC6D1A0FB784F18() {
  level endon("game_ended");
  level endon("stop_elevator_startHadirElevator_early");
  scripts\engine\utility::flag_wait("hadir_elevator_start");
  scripts\engine\utility::array_thread(level.players, ::_id_6189FFC24C16CC32);
  level scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_6189FFC24C16CC32);
  playertriggered = _id_9F2CAD8DEC31B772();
  scripts\engine\utility::flag_set("hadir_elevator_seen", playertriggered);
  _id_241A98C751F994DD();
  thread _id_3828D19A1D89FCAD((-398, 13529, -3963), (0, 315, 0));
  thread _id_3828D19A1D89FCAD((-285, 13529, -3964), (0, 315, 0));
  thread _id_3828D19A1D89FCAD((-168, 13529, -3964), (0, 315, 0));
  thread _id_3828D19A1D89FCAD((-102, 13579, -3964), (0, 45, 0));
  thread _id_3828D19A1D89FCAD((-102, 13689, -3964), (0, 45, 0));
  thread _id_3828D19A1D89FCAD((-175, 13740, -3964), (0, 315, 0));
  thread _id_3828D19A1D89FCAD((-285, 13740, -3964), (0, 315, 0));
  thread _id_3828D19A1D89FCAD((-395, 13740, -3964), (0, 315, 0));
  thread _id_3828D19A1D89FCAD((-464, 13689, -3964), (0, 45, 0));
  thread _id_3828D19A1D89FCAD((-464, 13579, -3964), (0, 45, 0));
  scripts\engine\utility::flag_wait("elevator_start_vo_done");

  if(getDvar("dvar_6A191150F4AFCE8B", "a") == "a")
    _id_940C08E6703BB715(1);
  else
    _id_940C08E6703BB715(0);

  _id_5528B94BD5DBAE61();
  thread _id_995A82A7C1DC2EA7("floor_7_ascender", "floor_7_ascender");
  thread _id_995A82A7C1DC2EA7("floor_7_group_3_trigger", "floor_7_group_3");
  thread _id_995A82A7C1DC2EA7("floor_7_group_3_trigger", "floor_7_group_4");
  thread _id_995A82A7C1DC2EA7("floor_7_group_5_trigger", "floor_7_group_5");
  thread _id_995A82A7C1DC2EA7("floor_7_stairs_trigger", "floor_8_trigger_ai");
  thread _id_995A82A7C1DC2EA7("floor_7_stairs_trigger", "floor_7_stairs");
  thread _id_995A82A7C1DC2EA7("floor_8_trigger_ai_2", "floor_8_trigger_ai_2");
  thread _id_995A82A7C1DC2EA7("floor_8_trigger_ai_3", "floor_8_trigger_ai_3");
  thread _id_995A82A7C1DC2EA7("floor_8_stairs_trigger", "floor_8_stairs");
  thread _id_995A82A7C1DC2EA7("floor_8_stairs_trigger", "ascender_attack_floor_9");
  thread _id_995A82A7C1DC2EA7("floor_5_trigger", "ascender_attack_floor_5");
  level thread _id_B01F8398E11978E0();
  scripts\engine\utility::flag_set("hadir_elevator_started", playertriggered);
  thread _id_11811C954BBA79E3::_id_A42ED29F372BEE6B();
  level._id_C36C08704A4D3B97.ent playsoundonmovingent("evt_raid4_elevator_start");
  _id_45F0E1DC4CE9ECCB::_id_CCC48E4E354C87DF("checkpoint_elevator_section_downstairs");
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_RAID_COMPLEX_JUGG_MAZE/ELEVATOR_START_HINT", "allies", 8);
  _id_BBAB50479E358B02();
  thread _id_5FA35DF1819CF4D8();
  thread _id_26E70546AB238842();
}

_id_940C08E6703BB715(_id_2C23DDEE21EC0098) {
  _id_BFF1E885FA16C324 = getEntArray("ascender_path_a_wall", "targetname");

  foreach(wall in _id_BFF1E885FA16C324) {
    if(isDefined(wall.script_noteworthy)) {
      if(istrue(_id_2C23DDEE21EC0098)) {
        if(istrue(wall.script_noteworthy == "remove")) {
          wall connectpaths();
          wall hide();
          wall notsolid();
        }

        continue;
      }

      if(istrue(wall.script_noteworthy == "add"))
        wall delete();
    }
  }

  if(getdvarint("dvar_BCC8261E109134D6", 1)) {
    index = getdvarint("dvar_906DB13C0AC1CCEC", 1);
    _id_7D1AA5814C852F2E = getEntArray("ascender_path_b_rope", "targetname");

    if(isDefined(_id_7D1AA5814C852F2E[index])) {
      _id_7D1AA5814C852F2E[index] hide();
      _id_7D1AA5814C852F2E[index] notsolid();
    }
  }

  if(istrue(_id_2C23DDEE21EC0098)) {
    key = "ascender_path_b_rope";
    _id_C8FE63AFAAA93EF0 = scripts\engine\utility::getStruct("ascender_b", "targetname");
  } else {
    key = "ascender_path_a_rope";
    _id_C8FE63AFAAA93EF0 = scripts\engine\utility::getStruct("ascender_a", "targetname");
  }

  ascenders = getentitylessscriptablearray("scriptable_military_ascendertop_heavy", "classname", _id_C8FE63AFAAA93EF0.origin, 128);

  foreach(ascender in ascenders)
  _id_18AF78602B67B70C::_id_F1BB8A269D750F18(0, ascender);
}

_id_995A82A7C1DC2EA7(_id_A95CF9509CE0D814, _id_CA8D3101C7736449) {
  level endon("game_ended");
  trigger = getEnt(_id_A95CF9509CE0D814, "targetname");

  for(;;) {
    trigger waittill("trigger", player);

    if(player scripts\cp\utility::is_valid_player()) {
      break;
    }
  }

  _id_18A73A64992DD07D::run_spawn_module(_id_CA8D3101C7736449);
}

_id_9F2CAD8DEC31B772() {
  level endon("game_ended");
  trigger = getEnt("hadir_elevator_start", "targetname");
  trigger endon("death");

  for(;;) {
    trigger waittill("trigger");

    foreach(player in level.players) {
      if(player istouching(trigger))
        return player;
    }

    wait 0.5;
  }
}

_id_E16BAE6344C9B5FD() {
  level endon("game_ended");

  for(;;) {
    foreach(player in level.players) {
      if(player _meth_9CC921A57FF4DEB5()) {
        while(player _meth_9CC921A57FF4DEB5())
          waitframe();

        return;
      }
    }

    wait 0.2;
  }
}

_id_26E70546AB238842() {
  level endon("game_ended");
}

_id_6189FFC24C16CC32() {
  thread _id_B67EEE0D092303E4();
  thread _id_E5E1341EDEC4994C();
}

_id_B67EEE0D092303E4() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    while(!self _meth_9CC921A57FF4DEB5())
      waitframe();

    og_attackeraccuracy = self.attackeraccuracy;

    while(self _meth_9CC921A57FF4DEB5()) {
      _id_784A5B13769F2303 = og_attackeraccuracy * 0.5;
      self.attackeraccuracy = _id_784A5B13769F2303;
      waitframe();

      if(self.attackeraccuracy != _id_784A5B13769F2303)
        og_attackeraccuracy = self.attackeraccuracy;
    }

    self.attackeraccuracy = og_attackeraccuracy;
  }
}

_id_E5E1341EDEC4994C() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  _id_BDA1DE83E1856735 = 0;

  for(;;) {
    if((self isonground() || self _meth_415FE9EECA7B2E2B() || self ismantling() || self isonladder() || self _meth_9CC921A57FF4DEB5()) && _id_BDA1DE83E1856735 > 0) {
      _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("falling");
      self.shouldskiplaststand = 0;
      _id_BDA1DE83E1856735 = 0;
    } else
      _id_BDA1DE83E1856735++;

    if(_id_BDA1DE83E1856735 > 15) {
      if(_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("mantle")) {
        _id_3B64EB40368C1450::set("falling", "mantle", 0);
        self.shouldskiplaststand = 1;
      }
    }

    waitframe();
  }
}

_id_1D894DD8F9B99CFA() {
  level._id_C36C08704A4D3B97.parts = [];
  _id_C471DB4F2371DC3D("body", 1);
  _id_C471DB4F2371DC3D("floor", 1);
  _id_C471DB4F2371DC3D("counterweight", 0);
  _id_305AF0FA4496E2FB();
  _id_8F636FF24A04461C = _id_D993F3ABB12DE672(level._id_C36C08704A4D3B97.ent.origin[2]);

  foreach(weight in level._id_C36C08704A4D3B97.parts["counterweight"]) {
    _id_780BB16E4220EB01 = scripts\engine\utility::getclosest(weight.origin, scripts\engine\utility::getStructArray("counterweight_animnode", "targetname"));
    weight.animnode = _id_780BB16E4220EB01 scripts\engine\utility::spawn_script_origin();
    weight.animnode linkTo(weight);
    _id_D4CF75E8A617D80C = (weight.origin[0], weight.origin[1], _id_8F636FF24A04461C);
    weight.origin = _id_D4CF75E8A617D80C;
  }

  level thread _id_6F8FDED7F6B63F00();
}

_id_B4A933DF645F0FEA(_id_73AEDA9A3D3A4FF0) {
  self.objid = scripts\cp\cp_objectives::requestworldid("elevator_counterweight", 1);
  objective_setplayintro(self.objid, 0);
  objective_setbackground(self.objid, 0);
  objective_state(self.objid, "current");
  objective_icon(self.objid, "icon_waypoint_objective_general");
  objective_onentity(self.objid, self);
  thread _id_55B40F5D42AD0D92();
}

_id_55B40F5D42AD0D92() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("hadir_elevator_crashed");
  scripts\cp\cp_objectives::freeworldid("elevator_counterweight");
}

_id_305AF0FA4496E2FB() {
  _id_FC4AB42EEEE0A331 = getEntArray("damagable_lever_left", "targetname");
  _id_707FC0DA93E3BD44 = getEntArray("damagable_lever_right", "targetname");

  foreach(lever in _id_FC4AB42EEEE0A331)
  lever linkTo(level._id_C36C08704A4D3B97.ent);

  level._id_C36C08704A4D3B97.ent _id_B4A933DF645F0FEA();

  foreach(lever in _id_707FC0DA93E3BD44)
  lever linkTo(level._id_C36C08704A4D3B97.ent);
}

_id_C471DB4F2371DC3D(partname, _id_6D9A74E54792C614, hintstring, hintdist) {
  parts = getEntArray("elevator_" + partname, "targetname");

  foreach(index, part in parts) {
    if(istrue(_id_6D9A74E54792C614))
      part linkTo(level._id_C36C08704A4D3B97.ent);

    if(isDefined(hintstring)) {
      interact = scripts\engine\utility::getclosest(part.origin, scripts\engine\utility::getStructArray("elevator_part_" + partname, "targetname"));
      hintdist = scripts\engine\utility::_id_53C4C53197386572(hintdist, 300);
      ent = scripts\cp\utility::createhintobject(interact.origin, "HINT_BUTTON", undefined, hintstring, undefined, undefined, "show", hintdist, 360, 120, 60);
      ent linkTo(part);
      part._id_C5D3D8FF129F88BA = ent;
    }
  }

  level._id_C36C08704A4D3B97.parts[partname] = parts;
}

_id_6F8FDED7F6B63F00() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("hadir_elevator_started");
  _id_2BDB15A9FEFC719C = _id_18AF78602B67B70C::_id_DC1F6851FDA93BEC("damagable_lever_left", "elevator_counterweight", "left", level._id_C36C08704A4D3B97._id_3027D2806F8B9648, 1, "elevator_hanging_cable_left", "melee_cable_left");
  thread _id_3C41C3F8D1894B26(_id_2BDB15A9FEFC719C);
  _id_2BDB15A9FEFC719C = _id_18AF78602B67B70C::_id_DC1F6851FDA93BEC("damagable_lever_right", "elevator_counterweight", "right", level._id_C36C08704A4D3B97._id_3027D2806F8B9648, 1, "elevator_hanging_cable_right", "melee_cable_right");
  thread _id_3C41C3F8D1894B26(_id_2BDB15A9FEFC719C);
}

_id_3C41C3F8D1894B26(_id_2BDB15A9FEFC719C) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("hadir_elevator_crashed");

  foreach(lever in _id_2BDB15A9FEFC719C) {
    if(isDefined(lever)) {
      lever notify("weight_freefell");
      lever delete();
    }
  }
}

_id_39D03BEB56AEBB4B(_id_24D3168A9B521E76) {
  level endon("game_ended");
  level endon("hadir_elevator_freefall");
  _id_24D3168A9B521E76._id_C5D3D8FF129F88BA makeusable();

  for(;;) {
    _id_24D3168A9B521E76._id_C5D3D8FF129F88BA waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    _id_24D3168A9B521E76._id_C5D3D8FF129F88BA _meth_DFB78B3E724AD620(0);
    level._id_C36C08704A4D3B97._id_DEE9F87BDE5FC5EF = 1;
    _id_D85C2330B73D4217();

    if(!level._id_C36C08704A4D3B97._id_2F10825BA72AADD1) {
      player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_RAID_COMPLEX_JUGG_MAZE/ELEVATOR_BRAKES_ENGAGED", 5);
      _id_24D3168A9B521E76._id_C5D3D8FF129F88BA _meth_DFB78B3E724AD620(1);
      continue;
    }

    wait 10;

    for(_id_AC0E594AC96AA3A8 = 5; _id_AC0E594AC96AA3A8 > 0; _id_AC0E594AC96AA3A8--) {
      _id_AA543F4F2B4F9BFA = undefined;

      switch (_id_AC0E594AC96AA3A8) {
        case 5:
          _id_AA543F4F2B4F9BFA = &"CP_RAID_COMPLEX_JUGG_MAZE/ELEVATOR_RESTARTING_5";
          break;
        case 4:
          _id_AA543F4F2B4F9BFA = &"CP_RAID_COMPLEX_JUGG_MAZE/ELEVATOR_RESTARTING_4";
          break;
        case 3:
          _id_AA543F4F2B4F9BFA = &"CP_RAID_COMPLEX_JUGG_MAZE/ELEVATOR_RESTARTING_3";
          break;
        case 2:
          _id_AA543F4F2B4F9BFA = &"CP_RAID_COMPLEX_JUGG_MAZE/ELEVATOR_RESTARTING_2";
          break;
        case 1:
          _id_AA543F4F2B4F9BFA = &"CP_RAID_COMPLEX_JUGG_MAZE/ELEVATOR_RESTARTING_1";
          break;
      }

      scripts\cp\cp_hud_message::teamhudtutorialmessage(_id_AA543F4F2B4F9BFA, "allies", 1);
      wait 1;
    }

    scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_RAID_COMPLEX_JUGG_MAZE/ELEVATOR_RESTARTED", "allies", 5);
    level._id_C36C08704A4D3B97._id_DEE9F87BDE5FC5EF = 0;
    _id_BBAB50479E358B02();
    wait 3;
    _id_24D3168A9B521E76._id_C5D3D8FF129F88BA _meth_DFB78B3E724AD620(1);
  }
}

_id_21C90A9326D1AC5D(_id_669DF14195B54B9C) {
  level endon("game_ended");
  level endon("hadir_elevator_freefall");
  _id_669DF14195B54B9C._id_C5D3D8FF129F88BA makeusable();
  thread _id_DE1E9AD6FFB6F152(_id_669DF14195B54B9C._id_C5D3D8FF129F88BA);

  for(;;) {
    _id_669DF14195B54B9C._id_C5D3D8FF129F88BA waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    _id_669DF14195B54B9C._id_C5D3D8FF129F88BA _meth_DFB78B3E724AD620(0);

    if(level._id_C36C08704A4D3B97.moving) {
      player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_RAID_COMPLEX_JUGG_MAZE/ELEVATOR_MOVING");
      wait 1;
    } else {
      level._id_C36C08704A4D3B97._id_944FF926630F4A0F++;
      wait 1;
      level._id_C36C08704A4D3B97._id_944FF926630F4A0F--;
    }

    _id_669DF14195B54B9C._id_C5D3D8FF129F88BA _meth_DFB78B3E724AD620(1);
  }
}

_id_DE1E9AD6FFB6F152(_id_C5D3D8FF129F88BA) {
  level endon("game_ended");
  level endon("hadir_elevator_freefall");
  _id_E7C3AF5E1D23E805 = 0;

  for(;;) {
    if(_id_E7C3AF5E1D23E805) {
      if(level._id_C36C08704A4D3B97.moving && level._id_C36C08704A4D3B97._id_2F10825BA72AADD1) {
        _id_C5D3D8FF129F88BA setHintString(&"CP_RAID_COMPLEX_JUGG_MAZE/ELEVATOR_BRAKE_NOT_READY");
        _id_E7C3AF5E1D23E805 = 0;
      }
    } else if(!level._id_C36C08704A4D3B97.moving || !level._id_C36C08704A4D3B97._id_2F10825BA72AADD1) {
      _id_C5D3D8FF129F88BA setHintString(&"CP_RAID_COMPLEX_JUGG_MAZE/ELEVATOR_BRAKE");
      _id_E7C3AF5E1D23E805 = 1;
    }

    waitframe();
  }
}

_id_EF0F2E9F39B9E2F8(_id_1AF409DE0A7CA644) {
  level._id_C36C08704A4D3B97._id_FADA5AACD1C05046++;
  level notify("hadir_elevator_lever_destroyed");

  if(level._id_C36C08704A4D3B97._id_FADA5AACD1C05046 >= 2 || istrue(_id_1AF409DE0A7CA644)) {
    level notify("hadir_elevator_freefall");
    setglobalsoundcontext("dusty", "yes");
    level._id_C36C08704A4D3B97.ent playsoundonmovingent("evt_raid4_elevator_stop");
    level._id_C36C08704A4D3B97.ent stoploopsound("evt_raid4_elevator_move_lp");

    if(isDefined(level._id_C36C08704A4D3B97._id_AE4ABD3AC3882BFF))
      level._id_C36C08704A4D3B97._id_AE4ABD3AC3882BFF stoploopsound("evt_raid4_elevator_tension_lp");

    level._id_C36C08704A4D3B97.ent playsoundonmovingent("cp_raid4_elevator_drop_start_st");
    level._id_C36C08704A4D3B97.ent playsoundonmovingent("cp_raid4_elevator_drop_ramp_st");
    _id_5C638331CC854DAF(level._id_C36C08704A4D3B97.ent, 200);
    scripts\engine\utility::flag_set("hadir_elevator_crashed");
    thread _id_18A73A64992DD07D::run_spawn_module("hadir_spawn_wounded");
    _id_45F0E1DC4CE9ECCB::_id_CCC48E4E354C87DF("checkpoint_elevator_defend_start");
    level._id_EF0F2E9F39B9E2F8 = undefined;
  }
}

_id_3829E422AE02045F(actorplayer, weight) {
  while(!isDefined(actorplayer.player_rig))
    waitframe();

  actorplayer.player_rig linkTo(weight);
  wait 1;
  actorplayer.entity lerpviewangleclamp(3, 1.5, 1.5, 60, 60, 45, 45);
}

_id_359B5E86F13D5EE2(player, weight, actors) {
  weight.animnode endon("anim_scene_interrupted");
  weight.animnode thread scripts\cp_mp\anim_scene::anim_scene_loop(actors, "cut_loop", 0, 0);
  starttime = gettime();

  for(_id_E0368BD6BBB6FE87 = 10 - weight._id_700E6448B4F61B66; player useButtonPressed() && !scripts\engine\utility::time_has_passed(starttime, _id_E0368BD6BBB6FE87); weight._id_700E6448B4F61B66 = weight._id_700E6448B4F61B66 + time) {
    time = 0.05;
    wait(time);
  }

  weight.animnode scripts\cp_mp\anim_scene::anim_scene_stop();

  if(scripts\engine\utility::time_has_passed(starttime, _id_E0368BD6BBB6FE87))
    return 1;

  return 0;
}

_id_5C638331CC854DAF(ent, damageradius) {
  level endon("game_ended");
  scripts\engine\utility::exploder("crank_sparks");
  goalheight = level._id_C36C08704A4D3B97._id_3027D2806F8B9648[2];
  dist = ent.origin[2] - goalheight;
  gravity = 385.827;
  time = sqrt(2 * dist / gravity);
  _id_D4CF75E8A617D80C = (ent.origin[0], ent.origin[1], goalheight);

  if(time > 0)
    ent moveTo(_id_D4CF75E8A617D80C, time);

  ent thread _id_F21E38278E8CBA4B(time);
  wait(time);
  scripts\engine\utility::exploder("elevator_crash_dust");

  foreach(ent in level._id_C36C08704A4D3B97.parts["body"]) {
    if(ent.model == "machinery_elevator_cabin_exterior")
      ent thread _id_11811C954BBA79E3::_id_898E4BAA69A9E38E();
  }

  ent stopsounds();
  damageradius = scripts\engine\utility::_id_53C4C53197386572(damageradius, 120);
  _id_60C7869645CE49FF = getEnt("elevator_crash_site", "targetname");

  if(isDefined(_id_60C7869645CE49FF)) {
    players = _id_60C7869645CE49FF getistouchingentities(level.players);

    foreach(player in players)
    ent _id_978869B32FEA7559(player, "MOD_CRUSH");
  }

  _id_11811C954BBA79E3::_id_97B69D7F6259C773();
}

_id_F21E38278E8CBA4B(time) {
  level endon("game_ended");
  _id_215954C226F78D18 = 0.95;
  _id_DA0E687DD0123A90 = time - _id_215954C226F78D18;
  _id_DA0E687DD0123A90 = clamp(_id_DA0E687DD0123A90, 0, 10);
  wait(_id_DA0E687DD0123A90);
  playsoundatpos(self.origin + (0, 0, 70), "cp_raid4_elevator_drop_crash_st");
}

_id_978869B32FEA7559(player, smeansofdeath, weapon) {
  player.shouldskipdeathsshield = 1;
  player.shouldskiplaststand = 1;
  player.nocorpse = 1;
  player.skipcorpse = 1;
  player._id_230A3287F9AD2965 = 1;
  player.ability_invulnerable = undefined;
  player _id_25845ACA699D038D::setdamageflag(1, 0);

  if(isDefined(weapon))
    player dodamage(player.maxhealth, self.origin, self, self, smeansofdeath, weapon);
  else
    player dodamage(player.maxhealth, self.origin, self, self, smeansofdeath);
}

_id_96C811F6377EE870(destination, flagname, speed, _id_B23ED70248D846B5, _id_8195BA3E74804382) {
  level notify("elevator_moveTo");
  level endon("elevator_moveTo");
  level endon("game_ended");
  level endon("hadir_elevator_crashed");
  level endon("hadir_elevator_freefall");

  if(isvector(destination))
    height = destination[2];
  else {
    _id_3C590B0EE220AFA3 = level._id_C36C08704A4D3B97._id_3027D2806F8B9648[2];
    _id_C978CB0E8E5AB65D = level._id_C36C08704A4D3B97._id_C93B1563BD093942[2];
    height = scripts\engine\math::factor_value(_id_3C590B0EE220AFA3, _id_C978CB0E8E5AB65D, destination);
  }

  _id_8F636FF24A04461C = _id_D993F3ABB12DE672(height);
  origin = level._id_C36C08704A4D3B97.ent.origin;
  _id_8BE1C88B2070BFD8 = height - origin[2];
  _id_D4CF75E8A617D80C = (origin[0], origin[1], height);
  speed = scripts\engine\utility::_id_53C4C53197386572(speed, level._id_C36C08704A4D3B97._id_2F10825BA72AADD1);
  speed = getdvarint("dvar_48B2866EEA22EBDC", speed);
  time = abs(origin[2] - height) / speed;
  _id_B23ED70248D846B5 = scripts\engine\utility::_id_53C4C53197386572(_id_B23ED70248D846B5, 0.5);
  _id_8195BA3E74804382 = scripts\engine\utility::_id_53C4C53197386572(_id_8195BA3E74804382, 0.5);
  accel = min(time * _id_B23ED70248D846B5, 3);
  decel = min(time * _id_8195BA3E74804382, 5);
  level._id_C36C08704A4D3B97.moving = 1;
  level._id_C36C08704A4D3B97.ent moveTo(_id_D4CF75E8A617D80C, time, accel, decel);

  foreach(_id_7B1DF66974B696FB in level._id_C36C08704A4D3B97.parts["counterweight"]) {
    if(istrue(_id_7B1DF66974B696FB.active)) {
      continue;
    }
    _id_D4CF75E8A617D80C = (_id_7B1DF66974B696FB.origin[0], _id_7B1DF66974B696FB.origin[1], _id_8F636FF24A04461C);
    _id_7B1DF66974B696FB moveTo(_id_D4CF75E8A617D80C, time, accel, decel);
  }

  level._id_C36C08704A4D3B97.ent playLoopSound("evt_raid4_elevator_move_lp");
  wait(time);
  level._id_C36C08704A4D3B97.moving = 0;
  level._id_C36C08704A4D3B97.ent playsoundonmovingent("evt_raid4_elevator_stop");
  level._id_C36C08704A4D3B97.ent stoploopsound("evt_raid4_elevator_move_lp");
  level thread _id_7AD5228C801198EB();

  if(isDefined(flagname))
    scripts\engine\utility::flag_set(flagname);
}

_id_7AD5228C801198EB() {
  level endon("game_ended");

  if(isDefined(level._id_C36C08704A4D3B97._id_AE4ABD3AC3882BFF) && level._id_C36C08704A4D3B97._id_70D316467FB1733B) {
    level._id_C36C08704A4D3B97._id_AE4ABD3AC3882BFF playSound("evt_raid4_elevator_tension_lp_end");
    wait 0.2;
    level._id_C36C08704A4D3B97._id_AE4ABD3AC3882BFF stoploopsound("evt_raid4_elevator_tension_lp");
  }
}

_id_706E41507664AFC8() {
  level notify("elevator_moveTo");
  level._id_C36C08704A4D3B97.moving = 0;
  level._id_C36C08704A4D3B97.ent moveTo(level._id_C36C08704A4D3B97.ent.origin, 0.05);

  foreach(_id_7B1DF66974B696FB in level._id_C36C08704A4D3B97.parts["counterweight"]) {
    if(istrue(_id_7B1DF66974B696FB.active)) {
      continue;
    }
    _id_7B1DF66974B696FB moveTo(_id_7B1DF66974B696FB.origin, 0.05);
  }
}

_id_BBAB50479E358B02() {
  if(getdvarint("dvar_6A4984B074B4C212", 0)) {
    return;
  }
  if(!level._id_C36C08704A4D3B97._id_DEE9F87BDE5FC5EF && level._id_C36C08704A4D3B97._id_2F10825BA72AADD1 > 0)
    level thread _id_96C811F6377EE870(1, "hadir_elevator_escaped");
}

_id_D85C2330B73D4217() {
  if(level._id_C36C08704A4D3B97.moving && level._id_C36C08704A4D3B97._id_2F10825BA72AADD1 > 0)
    _id_96C811F6377EE870(level._id_C36C08704A4D3B97.ent.origin + (0, 0, 5 * level._id_C36C08704A4D3B97._id_2F10825BA72AADD1), undefined, level._id_C36C08704A4D3B97._id_2F10825BA72AADD1 * 0.5, 0, 1);
}

_id_D993F3ABB12DE672(_id_386C870EAFF4CB3C) {
  _id_54E71C48A1E2B0F5 = level._id_C36C08704A4D3B97._id_3027D2806F8B9648[2];
  _id_DCDFCC484872C78B = level._id_C36C08704A4D3B97._id_C93B1563BD093942[2];
  _id_BB6E0913136EA65C = scripts\engine\math::normalize_value(_id_54E71C48A1E2B0F5, _id_DCDFCC484872C78B, _id_386C870EAFF4CB3C);
  _id_599C17E8FD732604 = 1 - _id_BB6E0913136EA65C;
  _id_E1BF1F4FCC11A351 = getdvarfloat("dvar_04C5B21091DCF0F8", 0.5);
  _id_F0AADE93ECE844CD = _id_54E71C48A1E2B0F5 + (_id_DCDFCC484872C78B - _id_54E71C48A1E2B0F5) * _id_E1BF1F4FCC11A351;
  _id_64171E9441475CF3 = _id_DCDFCC484872C78B - 40;
  height = scripts\engine\math::factor_value(_id_F0AADE93ECE844CD, _id_64171E9441475CF3, _id_599C17E8FD732604);
  return height;
}

_id_5FA35DF1819CF4D8() {
  for(f = 4; f <= 8; f++) {
    groupname = "helevator_f" + f;
    _id_18A73A64992DD07D::registerambientgroup(groupname, 0, 2, 2, 0.5, undefined, groupname);
    thread _id_4350A6B7B389750D(groupname, f);
  }
}

_id_4350A6B7B389750D(groupname, _id_5DCB93DB1678CDAF) {
  level endon("hadir_elevator_crashed");
  level endon("game_ended");
  wait 1;
  z = scripts\engine\utility::getStructArray(groupname, "targetname")[0].origin[2];
  spawned = [];
  count = 0;
  scripts\engine\utility::flag_wait("counterweight_cut_start");

  for(;;) {
    _id_9713301690B896D5 = 0;

    if(spawned.size) {
      spawned = scripts\engine\utility::array_removedead_or_dying(spawned);

      if(!spawned.size) {
        wait 15;
        _id_18A73A64992DD07D::reset_spawn_count_from_groupname(groupname);
      }
    } else {
      foreach(player in level.players) {
        if(!player scripts\cp\utility::is_valid_player()) {
          continue;
        }
        if(player _meth_9CC921A57FF4DEB5() || player isonladder() || !player isonground()) {
          continue;
        }
        _id_52A49BA164974CF2 = player.origin[2];

        if(abs(_id_52A49BA164974CF2 - z) <= 300 || _id_5DCB93DB1678CDAF >= 6 && _id_52A49BA164974CF2 < z && z - _id_52A49BA164974CF2 < 500) {
          _id_9713301690B896D5 = 1;
          break;
        }
      }
    }

    if(_id_9713301690B896D5) {
      _id_F564CE57BB79FF69 = _id_18A73A64992DD07D::run_spawn_module(groupname);
      _id_F564CE57BB79FF69 waittill("death");
      spawned = _id_F564CE57BB79FF69.ai_spawned;
    }

    wait 1;
  }
}

_id_E38BA6BA9E3DC3E8() {
  _id_F20211593F86675D();
}

_id_F20211593F86675D() {
  level._id_D3B90C28E1C7DBBF = 1;
  _id_DB1C9BA21F529D03 = scripts\engine\utility::getStructArray("weapon_wall", "targetname");

  foreach(struct in _id_DB1C9BA21F529D03) {
    if(istrue(struct._id_0948C921601932E3)) {
      continue;
    }
    struct._id_0948C921601932E3 = 1;
    _id_E27137570124CFCB = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4(struct.weaponinfo);
    _id_6CC2126273AA22B3 = undefined;

    switch (struct.weaponinfo) {
      case "iw9_dm_mike14_mp":
        _id_6CC2126273AA22B3 = ["silencer", "fourxtherm01"];
        break;
      case "iw9_sm_beta_mp":
        _id_6CC2126273AA22B3 = ["silencer", "reflex04"];
        break;
      case "iw9_pi_golf17_mp":
        _id_6CC2126273AA22B3 = ["silencer", "reddot"];
        break;
      case "iw9_br_schotel_mp":
        _id_6CC2126273AA22B3 = ["grip_vert02"];
        break;
      case "iw9_sn_mromeo_mp":
        _id_6CC2126273AA22B3 = ["silencer_sn_01"];
        break;
    }

    if(isDefined(_id_6CC2126273AA22B3))
      _id_E27137570124CFCB = _id_E27137570124CFCB _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(_id_6CC2126273AA22B3);

    struct _id_9655BF427A5ABDB8(_id_E27137570124CFCB);
  }

  _id_D5ECF70A4D407B43 = scripts\engine\utility::getStructArray("start_offhand_struct", "targetname");

  if(isDefined(_id_D5ECF70A4D407B43))
    _id_18AF78602B67B70C::level_offhand_spawn(_id_D5ECF70A4D407B43);
}

_id_9655BF427A5ABDB8(objweapon) {
  sweapon = getcompleteweaponname(objweapon);
  _id_B8F5AC23CE0DFDE3 = spawn("weapon_" + sweapon, self.origin, 17);
  _id_B8F5AC23CE0DFDE3.angles = self.angles;
  _id_AEC66C8D309A2AFA = 0;
  _id_5D9B5B689A1846C8 = undefined;

  if(istrue(objweapon.hasalternate)) {
    _id_5D9B5B689A1846C8 = objweapon getaltweapon();
    _id_AEC66C8D309A2AFA = weaponclipsize(_id_5D9B5B689A1846C8);
    _id_B8F5AC23CE0DFDE3 itemweaponsetammo(weaponclipsize(objweapon), weaponstartammo(objweapon), weaponclipsize(objweapon), 1);
  } else
    _id_B8F5AC23CE0DFDE3 itemweaponsetammo(weaponclipsize(objweapon), weaponstartammo(objweapon));

  _id_B8F5AC23CE0DFDE3 thread _id_74502A9E0EF1F19C::watchweaponpickup(weaponclipsize(objweapon), weaponstartammo(objweapon));
  return _id_B8F5AC23CE0DFDE3;
}

_id_ECBD2EA8830F03DC() {
  level._id_8CA6ABA535F80509 = scripts\engine\utility::getStructArray("elevator_fire_barrels", "targetname");

  foreach(_id_DDC4E4BDECFF28CD in level._id_8CA6ABA535F80509) {
    scriptable = spawnscriptable("decor_barrels_gameplay_flammable_noent", _id_DDC4E4BDECFF28CD.origin, _id_DDC4E4BDECFF28CD.angles);
    scriptable.parentstruct = _id_DDC4E4BDECFF28CD;
    _id_DDC4E4BDECFF28CD.scriptable = scriptable;
  }
}