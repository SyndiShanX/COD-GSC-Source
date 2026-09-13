/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_407e0f6fc77840b3.gsc
***********************************************/

main() {
  scripts\engine\utility::flag_wait("both_players_intro_binks_complete");
  scripts\engine\utility::flag_wait("cp_jugg_maze_lasers_create_script_completed");
  level._id_E88DDD791BC1A3E0 = 1000;
  _id_2318486684A97DBB();
  _id_D26A34C33A5C00EE();
  level._id_9E60A47EF1BA6272 = scripts\engine\utility::getStruct("3man_door_laser_1", "script_noteworthy");
  level._id_9E60A37EF1BA603F = scripts\engine\utility::getStruct("3man_door_laser_2", "script_noteworthy");
  level._id_9E60A27EF1BA5E0C = scripts\engine\utility::getStruct("3man_door_laser_3", "script_noteworthy");
  level._id_9E60A17EF1BA5BD9 = scripts\engine\utility::getStruct("3man_door_laser_4", "script_noteworthy");
  level thread _id_18AF78602B67B70C::_id_92233BCD56EA95C5("3man_door_laser_1", 1, 150, undefined, "iw9_door_metal_bars_open", undefined, "iw9_door_metal_bars_close");
  level thread _id_18AF78602B67B70C::_id_92233BCD56EA95C5("3man_door_laser_2", 1, 200, undefined, "iw9_door_metal_bars_open", undefined, "iw9_door_metal_bars_close");
  level thread _id_18AF78602B67B70C::_id_92233BCD56EA95C5("3man_door_laser_3", 1, 200, undefined, "iw9_door_metal_bars_open", undefined, "iw9_door_metal_bars_close");
  level thread _id_18AF78602B67B70C::_id_92233BCD56EA95C5("3man_door_laser_4", 1, 233, undefined, "iw9_door_metal_bars_open", undefined, "iw9_door_metal_bars_close");
  _id_E7C6723FDD17D915("3man_door_laser_2");
  _id_E7C6723FDD17D915("3man_door_laser_3");
  level._id_BBD6C4F67F32DBF0 = scripts\engine\utility::getStruct("jugg_maze_breadcrumb_1", "targetname");
  level._id_BBD6C7F67F32E289 = scripts\engine\utility::getStruct("jugg_maze_breadcrumb_2", "targetname");
  level._id_BBD6C6F67F32E056 = scripts\engine\utility::getStruct("jugg_maze_breadcrumb_3", "targetname");
  level._id_8739AC8958071FA3 = ::_id_C3575AE22BE7809B;
  level._id_8B27465C29D6521B = scripts\engine\utility::getStruct("door_lock_post_laser_3", "targetname");
  doors = getentitylessscriptablearray(undefined, undefined, level._id_8B27465C29D6521B.origin, 82, "door");

  if(!isDefined(level._id_D5004D58A7E1D8DE))
    level._id_D5004D58A7E1D8DE = doors;

  foreach(door in doors)
  _id_531C536DCD04E20F::_id_FBBFE6F05EDA5EB1(door);

  if(!isDefined(level._id_18E49A0C7828BE42))
    level thread _id_5F973A816DD5EB51();

  goalheight = scripts\engine\utility::getStruct("laser_maze_height_ref", "targetname");
  level thread _id_18AF78602B67B70C::_id_DC1F6851FDA93BEC("damagable_lever", "lasertrap_counterweight", undefined, goalheight.origin);
  level thread _id_850F69C7AF00463C();
  thread _id_A69497FB557DFA9B();
}

_id_850F69C7AF00463C() {
  level endon("game_ended");
  level endon("traps_defused_laser_sentry_defuse_mines");
  lever = getEnt("damagable_lever", "targetname");
  lever waittill("weight_freefell");
  playsoundatpos((4116, 15217, -4177), "cp_raid4_concrete_block_fall");
  playFX(level._effect["vfx_cp_raid_concrete_block_impact"], (4128.67, 15219.3, -4215.03));
  _id_BD901692981B143A = getEnt("concrete_block_lower_cable", "script_noteworthy");

  if(isDefined(_id_BD901692981B143A))
    _id_BD901692981B143A delete();
}

_id_E7C6723FDD17D915(_id_92C4DE821390F609) {
  doors = getEntArray(_id_92C4DE821390F609, "script_noteworthy");
  _id_1139C80E805299D5 = _id_92C4DE821390F609 + "_clip";
  clip = getEnt(_id_1139C80E805299D5, "script_noteworthy");

  if(isDefined(doors)) {
    foreach(door in doors) {
      if(isDefined(clip))
        clip linkTo(door);
    }
  }
}

_id_2318486684A97DBB() {
  level._id_32CEBEA67CB58988 = scripts\engine\utility::getStruct("door_lock_to_hadir", "targetname");
  level._id_32CEBEA67CB58988.doors = getentitylessscriptablearray(undefined, undefined, level._id_32CEBEA67CB58988.origin, 92, "door");
}

_id_D26A34C33A5C00EE() {
  if(!isDefined(level._id_32CEBEA67CB58988))
    _id_2318486684A97DBB();

  foreach(door in level._id_32CEBEA67CB58988.doors)
  _id_531C536DCD04E20F::_id_FBBFE6F05EDA5EB1(door);

  scripts\engine\utility::flag_set("hadir_elevator_door_locked");
}

_id_52FABB5C93DEB661() {
  if(!isDefined(level._id_32CEBEA67CB58988))
    _id_2318486684A97DBB();

  scripts\engine\utility::flag_wait("hadir_elevator_door_locked");

  foreach(door in level._id_32CEBEA67CB58988.doors)
  _id_531C536DCD04E20F::_id_B092780F9EC4496E(door);

  scripts\engine\utility::flag_set("hadir_elevator_door_unlocked");
  scripts\engine\utility::flag_clear("hadir_elevator_door_locked");
}

_id_885D722C75B8B444(group) {
  level notify("laser_section_ai_" + group.group_name, self);

  if(isDefined(self.spawner.script_parameters) && self.spawner.script_parameters == "grenade_tosser") {
    self.grenadeammo = 4;
    thread _id_8E92C0FD61AEFA6B();
  } else
    thread _id_9EB315B50EC407AA();
}

_id_9EB315B50EC407AA() {
  self endon("death");
  wait 1;
  self.grenadeweapon = nullweapon();
  self.grenadeammo = 0;
}

_id_1444276EB95F990B() {
  self endon("death");
  level endon("game_ended");
  scripts\engine\utility::flag_wait("3man_door_laser_4_door_open");
  thread _id_13D1C402F1421C35::throwgrenadeatplayerasap_combat_utility();
}

_id_CF412881BF661730(_id_7F5945B55E97B8B0, _id_FA9175E962BF664E) {
  level notify("laser_section_1");
  level notify("laser_section_2");
  level notify("laser_section_3");
  level notify("laser_section_4");
  level notify("laser_section_5");
  level notify("laser_section_6");
  waitframe();

  switch (_id_7F5945B55E97B8B0) {
    case 1:
      if(istrue(_id_FA9175E962BF664E))
        _id_18A73A64992DD07D::run_spawn_module("laser_section_1");
      else
        level thread _id_18AF78602B67B70C::_id_1A477014CE8F4CE2("spawn_trigger_laser_section_1");

      break;
    case 2:
      if(istrue(_id_FA9175E962BF664E)) {
        _id_18A73A64992DD07D::run_spawn_module("laser_section_2");
        _id_18A73A64992DD07D::run_spawn_module("laser_section_6");
      } else {
        level thread _id_18AF78602B67B70C::_id_1A477014CE8F4CE2("spawn_trigger_laser_section_2");
        level thread _id_18AF78602B67B70C::_id_1A477014CE8F4CE2("spawn_trigger_laser_section_6");
      }

      break;
    case 3:
      if(istrue(_id_FA9175E962BF664E))
        _id_18A73A64992DD07D::run_spawn_module("laser_section_3");
      else
        level thread _id_18AF78602B67B70C::_id_1A477014CE8F4CE2("spawn_trigger_laser_section_3");

      break;
    case 4:
    default:
      if(istrue(_id_FA9175E962BF664E)) {
        _id_18A73A64992DD07D::run_spawn_module("laser_section_4");
        _id_18A73A64992DD07D::run_spawn_module("laser_section_5");
      } else {
        level thread _id_18AF78602B67B70C::_id_1A477014CE8F4CE2("spawn_trigger_laser_section_4");
        level thread _id_18AF78602B67B70C::_id_1A477014CE8F4CE2("spawn_trigger_laser_section_5");
      }

      break;
  }
}

_id_4EE58979F91CBB23() {
  scripts\engine\utility::flag_wait("cp_jugg_maze_create_script_completed");
  _id_18AF78602B67B70C::_id_F331637729C41AA1("laser_section_ai", ::_id_885D722C75B8B444);
  level.skip_nav_check_on_spectate_respawn = 1;
  level.disable_start_spawn_on_navmesh = 1;
  level notify("force_kill_older_laserprogression_thread");
  level._id_B3A61E1FD4CE7D8A = 4;
  thread _id_A0302DA1C5D4F70A();
  _id_45F0E1DC4CE9ECCB::_id_CCC48E4E354C87DF("checkpoint_mine_postlasers");
  _id_568AA623C33A6726();
  _id_242A2441CBD54AF1::_id_DF891834AF7D6F74(level._id_B3A61E1FD4CE7D8A);
  _id_CF412881BF661730(level._id_B3A61E1FD4CE7D8A);

  if(getdvarint("dvar_A3A5CBE8DD44C5BA", 0) == 0)
    thread _id_242A2441CBD54AF1::_id_31BD3D5C49857F2D();

  scripts\engine\utility::flag_wait("3man_door_laser_4_door_open");
  level thread _id_D00C61E207581AA4();
  scripts\engine\utility::flag_wait("traps_defused_laser_sentry_defuse_mines_4");
}

_id_A0302DA1C5D4F70A() {
  level._id_36087E204C6F61CA = scripts\engine\utility::getStructArray("trophy_spawn", "targetname");

  foreach(struct in level._id_36087E204C6F61CA)
  thread _id_03A246920C9288C4::_id_233602CC27D9FCF8(struct, 1, 1000, 200, "axis");
}

_id_89EA2CE2247DA968(_id_D713CCC7F145379B) {
  scripts\engine\utility::flag_wait("cp_jugg_maze_create_script_completed");
  scripts\engine\utility::flag_wait("mine_laser_section_started");
  level notify("force_kill_older_laserprogression_thread");
  level._id_B3A61E1FD4CE7D8A = _id_D713CCC7F145379B;
  _id_7B33D0A786DCD185 = undefined;

  switch (_id_D713CCC7F145379B) {
    case 1:
      _id_7B33D0A786DCD185 = undefined;
      break;
    case 2:
      _id_7B33D0A786DCD185 = 1;
      break;
    case 3:
      _id_7B33D0A786DCD185 = 2;
      break;
    default:
      break;
  }

  thread _id_5F973A816DD5EB51(_id_7B33D0A786DCD185);
}

_id_5F973A816DD5EB51(_id_7B33D0A786DCD185) {
  level endon("game_ended");
  level endon("force_kill_older_laserprogression_thread");

  if(!isDefined(_id_7B33D0A786DCD185))
    _id_7B33D0A786DCD185 = 0;

  scripts\engine\utility::flag_wait("mine_laser_section_started");
  level notify("farah_stop_squad_wipe_monitor");

  if(_id_7B33D0A786DCD185 == 0) {
    scripts\cp\utility::_id_3069B525E1C98FAF("mine_lasers_" + level._id_B3A61E1FD4CE7D8A);
    _id_11811C954BBA79E3::_id_9D7CE2AFF0635EBF();
    _id_242A2441CBD54AF1::_id_DF891834AF7D6F74(level._id_B3A61E1FD4CE7D8A);
    _id_CF412881BF661730(level._id_B3A61E1FD4CE7D8A);
    _id_56EF5F8EBF2A76CE(level._id_B3A61E1FD4CE7D8A);
    scripts\engine\utility::flag_wait("3man_door_laser_1_door_open");
    scripts\engine\utility::flag_wait("traps_defused_laser_sentry_defuse_mines");
    level._id_B3A61E1FD4CE7D8A++;
  }

  if(_id_7B33D0A786DCD185 <= 1) {
    scripts\cp\utility::_id_3069B525E1C98FAF("mine_lasers_" + level._id_B3A61E1FD4CE7D8A);
    _id_11811C954BBA79E3::_id_9D7CE3AFF06360F2();
    _id_568AA623C33A6726();
    level notify("set_laser_respawning");
    _id_56EF5F8EBF2A76CE(level._id_B3A61E1FD4CE7D8A);
    _id_242A2441CBD54AF1::_id_DF891834AF7D6F74(level._id_B3A61E1FD4CE7D8A);
    _id_CF412881BF661730(level._id_B3A61E1FD4CE7D8A);

    if(getdvarint("dvar_A3A5CBE8DD44C5BA", 0) == 0)
      thread _id_242A2441CBD54AF1::_id_31BD375C498571FB();

    scripts\engine\utility::flag_wait("3man_door_laser_2_door_open");
    level._id_B3A61E1FD4CE7D8A++;
  }

  if(_id_7B33D0A786DCD185 <= 2) {
    scripts\cp\utility::_id_3069B525E1C98FAF("mine_lasers_" + level._id_B3A61E1FD4CE7D8A);
    _id_568AA623C33A6726();
    level notify("set_laser_respawning");
    _id_56EF5F8EBF2A76CE(level._id_B3A61E1FD4CE7D8A);
    _id_242A2441CBD54AF1::_id_DF891834AF7D6F74(level._id_B3A61E1FD4CE7D8A);
    _id_CF412881BF661730(level._id_B3A61E1FD4CE7D8A);

    if(getdvarint("dvar_A3A5CBE8DD44C5BA", 0) == 0)
      thread _id_242A2441CBD54AF1::_id_31BD365C49856FC8();

    if(getdvarint("dvar_A3A5CBE8DD44C5BA", 0) == 0)
      thread _id_242A2441CBD54AF1::_id_31BD3D5C49857F2D();

    scripts\engine\utility::flag_wait("3man_door_laser_3_door_open");
    scripts\engine\utility::flag_wait("traps_defused_laser_sentry_defuse_mines_3");
    level notify("set_default_respawning");
    level._id_B3A61E1FD4CE7D8A++;
  }

  scripts\cp\utility::_id_3069B525E1C98FAF("mine_lasers_" + level._id_B3A61E1FD4CE7D8A);
  _id_11811C954BBA79E3::_id_9D7CE4AFF0636325();
  _id_45F0E1DC4CE9ECCB::_id_CCC48E4E354C87DF("checkpoint_mine_postlasers");
  _id_568AA623C33A6726();
  _id_242A2441CBD54AF1::_id_DF891834AF7D6F74(level._id_B3A61E1FD4CE7D8A);
  _id_CF412881BF661730(level._id_B3A61E1FD4CE7D8A);
  thread _id_A0302DA1C5D4F70A();
  scripts\engine\utility::flag_wait("3man_door_laser_4_door_open");
  level thread _id_D00C61E207581AA4();
  scripts\engine\utility::flag_wait("traps_defused_laser_sentry_defuse_mines_4");
}

_id_8E92C0FD61AEFA6B() {
  self endon("death");
  level endon("game_ended");
  scripts\engine\utility::flag_wait("3man_door_laser_4_door_open");
  wait 2;
  _id_F3E5EC9ECAAF8E1B = self gettagorigin("tag_accessory_right");
  velocity = _id_09C8CB86CFB5609D(level._id_9E60A17EF1BA5BD9);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 1; _id_AC0E594AC96AA3A8++) {
    magicgrenademanual("frag_grenade_mp", _id_F3E5EC9ECAAF8E1B, velocity);
    wait 0.5;
  }
}

_id_09C8CB86CFB5609D(target) {
  dir = target.origin - self.origin;
  _id_C559C40F71C83747 = vectorNormalize(dir);
  speed = randomfloatrange(333, 666);
  velocity = _id_C559C40F71C83747 * speed;
  return velocity;
}

_id_D00C61E207581AA4() {
  _id_8E86184BC8FFE0EE(level._id_BBD6C4F67F32DBF0, 33);
  _id_531161A68E075AB6(0, level._id_BBD6C4F67F32DBF0);
  _id_8E86184BC8FFE0EE(level._id_BBD6C7F67F32E289, 34);
  _id_531161A68E075AB6(0, level._id_BBD6C7F67F32E289);

  if(!isDefined(level._id_0C6C8A6BC57170DB))
    level._id_0C6C8A6BC57170DB = scripts\engine\utility::getStruct("door_lock", "targetname");

  doors = undefined;

  if(!isDefined(level._id_0C6C8A6BC57170DB))
    doors = getentitylessscriptablearray(undefined, undefined, (-527.75, 9017.9, -3797.98), 64, "door");
  else
    doors = getentitylessscriptablearray(undefined, undefined, level._id_0C6C8A6BC57170DB.origin, 64, "door");

  level._id_6266E73962148BD0 = doors;

  foreach(door in doors)
  _id_531C536DCD04E20F::_id_FBBFE6F05EDA5EB1(door);

  thread _id_8E86184BC8FFE0EE(level._id_BBD6C6F67F32E056, 35, 1);
  _id_531161A68E075AB6(0, level._id_BBD6C6F67F32E056);
  level notify("kill_firebarrel_threads");
  level notify("mine_section_complete");
}

_id_8E86184BC8FFE0EE(struct, index, _id_88FA3468DDB1DB1A) {
  struct.index = index;
  struct._id_D31685C0A626FF37 = scripts\cp\cp_objectives::requestworldid("mine" + struct.index, 1 + int(struct.index));
  objective_setplayintro(struct._id_D31685C0A626FF37, 1);
  objective_setplayoutro(struct._id_D31685C0A626FF37, 1);
  objective_setlocation(struct._id_D31685C0A626FF37, 0, struct.origin);
  objective_state(struct._id_D31685C0A626FF37, "active");
  objective_icon(struct._id_D31685C0A626FF37, "icon_waypoint_objective_general");
  objective_removeallfrommask(struct._id_D31685C0A626FF37);

  if(istrue(_id_88FA3468DDB1DB1A)) {
    for(;;) {
      waitframe();
      players_in_range = 0;
      _id_EAC7308FE53BB0D8 = 0;
      _id_432026E906C458FE = [];

      foreach(player in level.players) {
        if(!player scripts\cp\utility::is_valid_player()) {
          if(isDefined(player.inhackring))
            player.inhackring = undefined;

          continue;
        }

        if(distancesquared(player.origin, struct.origin) > struct.radius * struct.radius) {
          if(isDefined(player.inhackring))
            player.inhackring = undefined;

          continue;
        }

        players_in_range++;

        if(!scripts\engine\utility::array_contains(_id_432026E906C458FE, player)) {
          _id_432026E906C458FE[_id_432026E906C458FE.size] = player;
          player.inhackring = 1;
        }

        switch (players_in_range) {
          case 1:
            objective_setlabel(struct._id_D31685C0A626FF37, &"CP_RAID_COMPLEX_JUGG_MAZE/REGROUP_1");
            break;
          case 2:
            objective_setlabel(struct._id_D31685C0A626FF37, &"CP_RAID_COMPLEX_JUGG_MAZE/REGROUP_2");
            break;
          case 3:
            objective_setlabel(struct._id_D31685C0A626FF37, &"CP_RAID_COMPLEX_JUGG_MAZE/REGROUP_3");
            break;
          case 4:
            objective_setlabel(struct._id_D31685C0A626FF37, &"CP_RAID1_BOSS1/REGROUP");
            break;
        }
      }

      if(players_in_range < 1) {
        continue;
      }
      if(players_in_range == level.players.size) {
        break;
      }
    }
  }
}

_id_531161A68E075AB6(_id_835ADD7D7B2ACA82, _id_D553A0A9462CF631) {
  self endon("death");
  level endon("game_ended");

  if(istrue(_id_835ADD7D7B2ACA82))
    _id_242A2441CBD54AF1::_id_9399FC86660D5D86(_id_D553A0A9462CF631, "player_reached_breadcrumb", squared(_id_D553A0A9462CF631.radius));
  else
    _id_62E11D77B25C1D30::_id_ADD4AC211AB1D84D(_id_D553A0A9462CF631.origin, _id_D553A0A9462CF631.radius);

  return;
}

_id_A69497FB557DFA9B() {
  level endon("game_ended");
  level endon("mine_section_complete");

  for(;;) {
    msg = level scripts\engine\utility::waittill_any_return_2("set_default_respawning", "set_laser_respawning");

    if(msg == "set_default_respawning")
      _id_ECA4E3B50A3D2DDA();
    else
      _id_0F6E176283800858();

    waitframe();
  }
}

_id_E41FC7E04E6C4F0B(_id_16E6F6D462356C04) {
  _id_16E6F6D462356C04 = scripts\engine\utility::_id_53C4C53197386572(_id_16E6F6D462356C04, "platform_player_start");
  _id_89770FE705541944 = scripts\engine\utility::getStructArray(_id_16E6F6D462356C04, "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    player = level.players[_id_AC0E594AC96AA3A8];

    if(!isDefined(level.player_respawn[_id_AC0E594AC96AA3A8]) || !isDefined(player.respawn_index)) {
      player.respawn_index = _id_AC0E594AC96AA3A8;
      player.shouldskiplaststand = 1;
      level.player_respawn[_id_AC0E594AC96AA3A8] = _id_89770FE705541944[_id_AC0E594AC96AA3A8];
    }
  }
}

_id_8D794889BE61B752(_id_16E6F6D462356C04) {
  _id_16E6F6D462356C04 = scripts\engine\utility::_id_53C4C53197386572(_id_16E6F6D462356C04, _id_A75C377A094AAFAE());
  _id_89770FE705541944 = scripts\engine\utility::getStructArray(_id_16E6F6D462356C04, "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(self == level.players[_id_AC0E594AC96AA3A8]) {
      if(!isDefined(level.player_respawn[_id_AC0E594AC96AA3A8])) {
        self.respawn_index = _id_AC0E594AC96AA3A8;
        self.shouldskiplaststand = 1;
        level.player_respawn[_id_AC0E594AC96AA3A8] = _id_89770FE705541944[_id_AC0E594AC96AA3A8];
      }

      return level.player_respawn[_id_AC0E594AC96AA3A8];
    }
  }
}

_id_F750B6D6971731BD() {
  _id_F42869166D50FBE9 = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(!isDefined(_id_F42869166D50FBE9) || _id_F42869166D50FBE9 == "")
    _id_F42869166D50FBE9 = getDvar("start");

  switch (_id_F42869166D50FBE9) {
    default:
      _id_E41FC7E04E6C4F0B(_id_A75C377A094AAFAE());
      break;
  }
}

_id_AA095E0559985E47(downed_player) {
  downed_player scripts\cp\utility::store_weapons_status([]);
  downed_player _id_12E2FB553EC1605E::_id_7DA7BD24B280D295(1);

  if(!isDefined(level.player_respawn) || !isDefined(downed_player.respawn_index) || !isDefined(level.player_respawn[downed_player.respawn_index]))
    _id_F750B6D6971731BD();

  _id_E0CBA2B0A5510D09 = level.player_respawn[downed_player.respawn_index];
  downed_player.respawn_forcespawnorigin = scripts\engine\utility::drop_to_ground(_id_E0CBA2B0A5510D09.origin, 32, -100);
  downed_player.respawn_forcespawnangles = downed_player getplayerangles(1);
  downed_player.forcespawnorigin = scripts\engine\utility::drop_to_ground(_id_E0CBA2B0A5510D09.origin, 32, -100);
  downed_player.forcespawnangles = downed_player getplayerangles(1);
  downed_player notify("entered_spectate");
  timer = 5;
  _id_19F0135BD917C05D = getdvarint("dvar_B4B6597A66C1EC75", 0);

  if(_id_19F0135BD917C05D != 0)
    timer = _id_19F0135BD917C05D;

  wait(timer);

  if(isDefined(downed_player.br_ammo)) {
    foreach(key, value in downed_player.br_ammo)
    downed_player.br_ammo[key] = 0;
  }

  downed_player.respawn_forcespawnorigin = scripts\engine\utility::drop_to_ground(_id_E0CBA2B0A5510D09.origin, 32, -100);
  downed_player.respawn_forcespawnangles = downed_player getplayerangles(1);
  downed_player.forcespawnorigin = scripts\engine\utility::drop_to_ground(_id_E0CBA2B0A5510D09.origin, 32, -100);
  downed_player.forcespawnangles = downed_player getplayerangles(1);
  downed_player._id_E2DCB2197ADCD829 = 0;
  downed_player._id_2C57AD05A29BA103 = undefined;
  downed_player _id_0AFB7E332AEE4BF2::instant_revive(downed_player);
  downed_player notify("last_stand_finished");
}

_id_71454DEA4D88A38C(_id_642470E1ABC1BBF9) {
  _id_642470E1ABC1BBF9.victim endon("disconnect");
  level endon("game_ended");

  while(istrue(self._id_E2DCB2197ADCD829))
    waitframe();

  return 0;
}

_id_2E8DF8E07F8231BF(player, damage_data) {
  if(isDefined(damage_data.attacker) && isai(damage_data.attacker)) {
    player.shouldskiplaststand = 0;
    player._id_2C57AD05A29BA103 = 1;
    return 1;
  } else
    return 0;
}

_id_56EF5F8EBF2A76CE(_id_D3735876B6E11D3C) {
  level._id_7B098327E305F16D = ::_id_2E8DF8E07F8231BF;
  level.modeplayerkilledspawn = ::_id_71454DEA4D88A38C;
  level._id_C121AA6DC74CCE91 = _id_0AFB7E332AEE4BF2::_id_2F75743C7FE59CFC;
  level._id_CAADFDA74F61A3CA = 1;
  level._id_608454029F3370F2 = 1;
  level._id_A3E60D4FD52EFC95 = 1;
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "handleSuicideDeath", ::_id_B62C81295DFAEF5A);
  noteworthy = "";

  switch (_id_D3735876B6E11D3C) {
    case 1:
      noteworthy = "lasers_part1_player_start";
      break;
    case 2:
      noteworthy = "lasers_part2_player_start";
      break;
    case 3:
      noteworthy = "lasers_part3_player_start";
      break;
    case 4:
      noteworthy = "lasers_part4_player_start";
      break;
    default:
      noteworthy = "platform_player_start";
      break;
  }

  _id_89770FE705541944 = scripts\engine\utility::getStructArray(noteworthy, "script_noteworthy");
  level.default_player_spawns = noteworthy;

  foreach(player in level.players) {
    if(!isDefined(player.respawn_index)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
        if(player == level.players[_id_AC0E594AC96AA3A8]) {
          player.respawn_index = _id_AC0E594AC96AA3A8;
          player.shouldskiplaststand = 1;
          level.player_respawn[_id_AC0E594AC96AA3A8] = _id_89770FE705541944[_id_AC0E594AC96AA3A8];
        }
      }
    }
  }
}

_id_B62C81295DFAEF5A(_id_11E39010477B79E4) {
  _id_11E39010477B79E4 = scripts\engine\utility::_id_53C4C53197386572(_id_11E39010477B79E4, 0);
  thread _id_7C506F2A7382AA2E(_id_11E39010477B79E4);
}

_id_7C506F2A7382AA2E(_id_11E39010477B79E4) {
  level endon("game_ended");
  self endon("disconnect");
  self.respawn_forcespawnorigin = self.origin;
  self.respawn_forcespawnangles = self getplayerangles(1);
  self.suicidespawndelay = 1;
  self._id_EC2E7871FEB66A8E = 0;

  if(isDefined(self.friendlydamage))
    self.friendlyfiredeath = 1;

  self._id_E2DCB2197ADCD829 = 1;
  wait 2;

  if(!istrue(self._id_2C57AD05A29BA103))
    self._id_E2DCB2197ADCD829 = undefined;
  else {
    self._id_2C57AD05A29BA103 = undefined;
    thread _id_C344AD0FAB5FF656(self, 1);
  }

  self waittill("spawned_player");
  self._id_EC2E7871FEB66A8E = undefined;
}

_id_C344AD0FAB5FF656(player, waittime) {
  level endon("game_ended");
  player endon("disconnect");
  wait(waittime);
  player._id_E2DCB2197ADCD829 = undefined;
}

_id_A75C377A094AAFAE() {
  level endon("game_ended");
  noteworthy = "";

  switch (level._id_B3A61E1FD4CE7D8A) {
    case 1:
      noteworthy = "lasers_part1_player_start";
      break;
    case 2:
      noteworthy = "lasers_part2_player_start";
      break;
    case 3:
      noteworthy = "lasers_part3_player_start";
      break;
    case 4:
      noteworthy = "lasers_part4_player_start";
      break;
    default:
      noteworthy = "platform_player_start";
      break;
  }

  return noteworthy;
}

_id_568AA623C33A6726() {
  level._id_CAADFDA74F61A3CA = undefined;
  level._id_608454029F3370F2 = undefined;
  level.enter_spectator_func = _id_0AFB7E332AEE4BF2::enable_dogtag_revive;
  level.getspawnpoint = _id_0598E0C00C8151F7::getspawnpoint;
  level._id_C121AA6DC74CCE91 = undefined;
  level._id_7B098327E305F16D = undefined;
  level.modeplayerkilledspawn = _id_0AFB7E332AEE4BF2::playerkilledspawn;
  level.all_players_skip_last_stand = 0;
  level.player_respawn = undefined;
  level.coop_gameshouldendfunc = undefined;
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "handleSuicideDeath", undefined);

  foreach(player in level.players) {
    player.respawn_index = undefined;
    player.shouldskiplaststand = 0;
  }
}

_id_0F6E176283800858() {
  level.enter_spectator_func = ::_id_AA095E0559985E47;
  level.getspawnpoint = ::_id_8D794889BE61B752;
  level.coop_gameshouldendfunc = _id_18AF78602B67B70C::_id_EDCE93CF6B7199A0;
  level._id_313F285051FA8329 = _id_18AF78602B67B70C::_id_EDCE93CF6B7199A0;
  level.all_players_skip_last_stand = 1;
  level.skip_nav_check_on_spectate_respawn = 1;
  level._id_3A0F2224B2310445 = 1;

  if(istrue(level._id_77F52E0CCB8547EB))
    thread scripts\cp\cp_gameskill::_id_06660798718EE459(1);

  scripts\cp\cp_gameskill::_id_0127B010126B6A90();

  foreach(player in level.players)
  player.shouldskiplaststand = 1;

  _id_18AF78602B67B70C::_id_08FF8C8BD1F7AA28("trap_plat_teamrespawn_cp");
  _id_18AF78602B67B70C::_id_55A28F2BA806FE97("trap_plat_respawn_cp");
  level._id_CF829458F676A8EF = 1;
  level._id_F4C8727CAC33C176 = 1;
  level._id_0E190575F56F40A5 = "traversal";

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
    return;
}

_id_ECA4E3B50A3D2DDA() {
  level._id_C121AA6DC74CCE91 = undefined;
  level._id_7B098327E305F16D = undefined;
  level.modeplayerkilledspawn = _id_0AFB7E332AEE4BF2::playerkilledspawn;
  level.all_players_skip_last_stand = 0;
  level.player_respawn = undefined;
  level.coop_gameshouldendfunc = undefined;
  level._id_313F285051FA8329 = undefined;
  level.enter_spectator_func = _id_0AFB7E332AEE4BF2::enable_dogtag_revive;
  level.getspawnpoint = _id_0598E0C00C8151F7::getspawnpoint;
  level._id_920CBA4B7B32D2A9 = 1;
  level._id_3A0F2224B2310445 = 0;
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "handleSuicideDeath", undefined);
  scripts\cp\cp_gameskill::_id_77E524F19EB4608F();

  foreach(player in level.players) {
    player.respawn_index = undefined;
    player.shouldskiplaststand = 0;
  }

  level._id_CF829458F676A8EF = undefined;
  level._id_F4C8727CAC33C176 = undefined;
  level._id_0E190575F56F40A5 = "combat";

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
    return;
}

_id_C3575AE22BE7809B(doors) {
  level endon("game_ended");

  foreach(door in doors) {
    _id_C729D49D406ACED8 = scripts\engine\utility::getclosest(door.origin, level.players);
    _id_B4CE3C22275DCDAE = door scripts\engine\math::is_point_on_right(_id_C729D49D406ACED8.origin);

    if(istrue(_id_B4CE3C22275DCDAE)) {
      door rotateYaw(90, 0.5);
      continue;
    }

    door rotateYaw(-90, 0.5);
  }
}