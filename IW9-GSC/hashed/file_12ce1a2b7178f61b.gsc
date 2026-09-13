/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_12ce1a2b7178f61b.gsc
***********************************************/

_id_A9DEFB00293742DE() {
  level._effect["harrier_red_laser"] = loadfx("vfx/iw8_cp/vfx_cp_trap_room_laser.vfx");
  level._effect["harrier_green_laser"] = loadfx("vfx/iw9/cp/vfx_cp_trap_green_laser.vfx");
  level._effect["jet_smoke"] = loadfx("vfx/iw8_mp/killstreak/vfx_hover_jet_smoke_ch.vfx");
  level._effect["jet_smoke1"] = loadfx("vfx/iw9/cp/vfx_cp_smoke_heavy.vfx");
  level._effect["vfx_ammo_beacon"] = loadfx("vfx/iw9/cp/vfx_beacon_light.vfx");
  level._effect["vfx_javelin_expl"] = loadfx("vfx/core/expl/javelin_explosion.vfx");
  level._effect["vfx_br_fire_plume"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_fire_plume.vfx");
  level._effect["vfx_gas_ring_player"] = loadfx("vfx/iw8_cp/br_ring/vfx_gas_ring_player.vfx");
  _id_18AF78602B67B70C::_id_C713EB7F9FE5D6FA();
}

_id_C75C245DCA22D0EC(_id_E835BD5EBF3BA5EB) {
  level endon("game_ended");

  if(istrue(level._id_77C01701810C8237)) {
    return;
  }
  level._id_77C01701810C8237 = 1;
  _id_1BD1AB149E9DBA98();
  thread _id_25700879EDC2479A();
  _id_679C2DA1C83EDB81();
  _id_B48C311FA7628B0E();
  _id_07CAEBC5D4875185::main();
  scripts\engine\utility::flag_set("level_stealth_initialized");

  if(!isDefined(_id_E835BD5EBF3BA5EB))
    _id_E835BD5EBF3BA5EB = 0;

  level thread _id_34DFC67DD9CBAC0B::_id_52A84590522475B3("vtol_samsite");
  level thread _id_EFFE43D92F9EBA8E("bunker_door");
  level thread _id_CD9879D46EF1F46D();
  level thread _id_45E7F23613B3B7A0(_id_E835BD5EBF3BA5EB);
  level thread _id_43CD833F1EE643BA();
  register_spawners();
}

_id_EFFE43D92F9EBA8E(targetname) {
  doors = getEntArray(targetname, "targetname");

  foreach(door in doors) {
    _id_5AC49E018B46B2CD = scripts\engine\utility::getStruct(door.target, "targetname");
    _id_20F3271DC43A6012 = scripts\engine\utility::getStruct(_id_5AC49E018B46B2CD.target, "targetname");
    _id_5AC49E018B46B2CD _id_34D2771929BD6022::_id_2FECC1AAB1890E7D(&"CP_HARRIER_BOSS/HOLD_TO_OPEN", "button_on_green", 72, 256, "duration_none", "hide");
    _id_20F3271DC43A6012 _id_34D2771929BD6022::_id_2FECC1AAB1890E7D(&"CP_HARRIER_BOSS/HOLD_TO_KEEP_OPEN", "button_on_green", 32, 64, "duration_none", "hide");
    _id_34D2771929BD6022::_id_05F7C6BF2110C0FE(door);
    door._id_7432D0D0FA70617C._id_785C56130FCDBC47 = "door_garage_button_press";
    door._id_590D3F80EE9B48CB._id_785C56130FCDBC47 = "door_garage_button_press";
  }
}

_id_25700879EDC2479A() {
  if(istrue(level._id_E515A1346A2EF95F)) {
    return;
  }
  level._id_E515A1346A2EF95F = 1;
  _id_18AF78602B67B70C::_id_F8C7F0B26960DF68();
  _id_EF0DA79BC6D64DC0 = scripts\engine\utility::getStruct("harrier_test_start", "script_noteworthy");
  buttonmodel = spawn("script_model", _id_EF0DA79BC6D64DC0.origin);
  buttonmodel.angles = _id_EF0DA79BC6D64DC0.angles;
  buttonmodel setModel("button_on");
  buttonmodel thread _id_A490A49AA45906C7();
}

_id_CD9879D46EF1F46D() {
  _id_17FE6694BC7DAD44 = getEnt("ascender_cable_rooftop_1", "script_noteworthy");
  _id_17FE6994BC7DB3DD = getEnt("ascender_cable_rooftop_2", "script_noteworthy");
  _id_17FE6894BC7DB1AA = getEnt("ascender_cable_rooftop_3", "script_noteworthy");
  _id_FEF5FF64838DC421 = getEnt("ascender_cable_left", "script_noteworthy");
  _id_FEF5FC64838DBD88 = getEnt("ascender_cable_center", "script_noteworthy");
  _id_FEF5FD64838DBFBB = getEnt("ascender_cable_right", "script_noteworthy");
  _id_98D23365B6E24E7C = scripts\engine\utility::getStruct("ascender_marker_rooftop_1", "script_noteworthy");
  _id_98D23665B6E25515 = scripts\engine\utility::getStruct("ascender_marker_rooftop_2", "script_noteworthy");
  _id_98D23565B6E252E2 = scripts\engine\utility::getStruct("ascender_marker_rooftop_3", "script_noteworthy");
  _id_4D209806446E6F39 = scripts\engine\utility::getStruct("ascender_marker_left", "script_noteworthy");
  _id_4D209506446E68A0 = scripts\engine\utility::getStruct("ascender_marker_center", "script_noteworthy");
  _id_4D209606446E6AD3 = scripts\engine\utility::getStruct("ascender_marker_right", "script_noteworthy");
  _id_33BA52A1EE9793B6 = scripts\engine\utility::getStruct("ascender_arm_rooftop_1", "script_noteworthy");
  _id_823D7D9206015CF7 = scripts\engine\utility::getStruct("ascender_arm_rooftop_2", "script_noteworthy");
  _id_71B6B26F7FB5A2B0 = scripts\engine\utility::getStruct("ascender_arm_rooftop_3", "script_noteworthy");
  _id_F3B62F6FD588A0D5 = scripts\engine\utility::getStruct("ascender_arm_left", "script_noteworthy");
  _id_2E86A20A10B3CF7D = scripts\engine\utility::getStruct("ascender_arm_center", "script_noteworthy");
  _id_09E4C4F98707FC02 = scripts\engine\utility::getStruct("ascender_arm_right", "script_noteworthy");
  level._id_BC2EC152B6EC2F34 = scripts\engine\utility::spawn_tag_origin(_id_33BA52A1EE9793B6.origin, scripts\engine\utility::ter_op(isDefined(_id_33BA52A1EE9793B6.angles), _id_33BA52A1EE9793B6.angles, (0, 0, 0)));
  level._id_BC2EC452B6EC35CD = scripts\engine\utility::spawn_tag_origin(_id_823D7D9206015CF7.origin, scripts\engine\utility::ter_op(isDefined(_id_823D7D9206015CF7.angles), _id_823D7D9206015CF7.angles, (0, 0, 0)));
  level._id_BC2EC352B6EC339A = scripts\engine\utility::spawn_tag_origin(_id_71B6B26F7FB5A2B0.origin, scripts\engine\utility::ter_op(isDefined(_id_71B6B26F7FB5A2B0.angles), _id_71B6B26F7FB5A2B0.angles, (0, 0, 0)));
  level._id_6E8C862706AE5F67 = scripts\engine\utility::spawn_tag_origin(_id_F3B62F6FD588A0D5.origin, scripts\engine\utility::ter_op(isDefined(_id_F3B62F6FD588A0D5.angles), _id_F3B62F6FD588A0D5.angles, (0, 0, 0)));
  level._id_E1317D0C528B53FF = scripts\engine\utility::spawn_tag_origin(_id_2E86A20A10B3CF7D.origin, scripts\engine\utility::ter_op(isDefined(_id_2E86A20A10B3CF7D.angles), _id_2E86A20A10B3CF7D.angles, (0, 0, 0)));
  level._id_BC03C4DEAA9C1918 = scripts\engine\utility::spawn_tag_origin(_id_09E4C4F98707FC02.origin, scripts\engine\utility::ter_op(isDefined(_id_09E4C4F98707FC02.angles), _id_09E4C4F98707FC02.angles, (0, 0, 0)));
  level._id_BC2EC152B6EC2F34 setModel("military_ascendertop_01");
  level._id_BC2EC452B6EC35CD setModel("military_ascendertop_01");
  level._id_BC2EC352B6EC339A setModel("military_ascendertop_01");
  level._id_6E8C862706AE5F67 setModel("military_ascendertop_01");
  level._id_E1317D0C528B53FF setModel("military_ascendertop_01");
  level._id_BC03C4DEAA9C1918 setModel("military_ascendertop_01");
  level._id_BC2EC152B6EC2F34 show();
  level._id_BC2EC452B6EC35CD show();
  level._id_BC2EC352B6EC339A show();
  level._id_6E8C862706AE5F67 show();
  level._id_E1317D0C528B53FF show();
  level._id_BC03C4DEAA9C1918 show();
  level._id_29EADCE247BA9D18 = _id_18AF78602B67B70C::_id_050326CC21187D35("ascendercoil_interact_rooftop_1", &"CP_HARRIER_BOSS/KICK_DOWN_ASCENDER", "tag_origin");
  level._id_29EADFE247BAA3B1 = _id_18AF78602B67B70C::_id_050326CC21187D35("ascendercoil_interact_rooftop_2", &"CP_HARRIER_BOSS/KICK_DOWN_ASCENDER", "tag_origin");
  level._id_29EADEE247BAA17E = _id_18AF78602B67B70C::_id_050326CC21187D35("ascendercoil_interact_rooftop_3", &"CP_HARRIER_BOSS/KICK_DOWN_ASCENDER", "tag_origin");
  level._id_DCF829B6983D5EFB = _id_18AF78602B67B70C::_id_050326CC21187D35("ascendercoil_interact_left", &"CP_HARRIER_BOSS/KICK_DOWN_ASCENDER", "tag_origin");
  level._id_97C8310BBE694643 = _id_18AF78602B67B70C::_id_050326CC21187D35("ascendercoil_interact_center", &"CP_HARRIER_BOSS/KICK_DOWN_ASCENDER", "tag_origin");
  level._id_D6D25B63A5C65344 = _id_18AF78602B67B70C::_id_050326CC21187D35("ascendercoil_interact_right", &"CP_HARRIER_BOSS/KICK_DOWN_ASCENDER", "tag_origin");
  level._id_7712FB8B3054EEEB = [];
  level._id_7712FB8B3054EEEB[level._id_7712FB8B3054EEEB.size] = level thread _id_18AF78602B67B70C::_id_CB272B35D348BA04(level._id_29EADCE247BA9D18, _id_98D23365B6E24E7C, _id_17FE6694BC7DAD44, level._id_BC2EC152B6EC2F34);
  level._id_7712FB8B3054EEEB[level._id_7712FB8B3054EEEB.size] = level thread _id_18AF78602B67B70C::_id_CB272B35D348BA04(level._id_29EADFE247BAA3B1, _id_98D23665B6E25515, _id_17FE6994BC7DB3DD, level._id_BC2EC452B6EC35CD);
  level._id_7712FB8B3054EEEB[level._id_7712FB8B3054EEEB.size] = level thread _id_18AF78602B67B70C::_id_CB272B35D348BA04(level._id_29EADEE247BAA17E, _id_98D23565B6E252E2, _id_17FE6894BC7DB1AA, level._id_BC2EC352B6EC339A);
  level._id_7712FB8B3054EEEB[level._id_7712FB8B3054EEEB.size] = level thread _id_18AF78602B67B70C::_id_CB272B35D348BA04(level._id_DCF829B6983D5EFB, _id_4D209806446E6F39, _id_FEF5FF64838DC421, level._id_6E8C862706AE5F67);
  level._id_7712FB8B3054EEEB[level._id_7712FB8B3054EEEB.size] = level thread _id_18AF78602B67B70C::_id_CB272B35D348BA04(level._id_97C8310BBE694643, _id_4D209506446E68A0, _id_FEF5FC64838DBD88, level._id_E1317D0C528B53FF);
  level._id_7712FB8B3054EEEB[level._id_7712FB8B3054EEEB.size] = level thread _id_18AF78602B67B70C::_id_CB272B35D348BA04(level._id_D6D25B63A5C65344, _id_4D209606446E6AD3, _id_FEF5FD64838DBFBB, level._id_BC03C4DEAA9C1918);
  _id_A3957180D1257DE9("gauntlet_create_1", undefined);
  _id_A3957180D1257DE9("gauntlet_create_2", undefined);
  _id_1380E3B50B89B8AE = getdvarint("dvar_81D6D58393CF66D4", 0);

  if(_id_1380E3B50B89B8AE > 0)
    thread _id_BFF5C2828D6ECED0(_id_1380E3B50B89B8AE);
}

_id_5723D06E515C51D0() {
  _id_4D209806446E6F39 = scripts\engine\utility::getStruct("ascender_marker_left", "script_noteworthy");
  _id_4D209506446E68A0 = scripts\engine\utility::getStruct("ascender_marker_center", "script_noteworthy");
  level thread _id_18AF78602B67B70C::_id_8091A29AB763E925(1, _id_4D209806446E6F39.origin, 256);
  level thread _id_18AF78602B67B70C::_id_8091A29AB763E925(1, _id_4D209506446E68A0.origin, 256);

  if(isDefined(level._id_DCF829B6983D5EFB))
    level._id_DCF829B6983D5EFB delete();

  if(isDefined(level._id_97C8310BBE694643))
    level._id_97C8310BBE694643 delete();

  _id_FEF5FF64838DC421 = getEnt("ascender_cable_left", "script_noteworthy");
  _id_FEF5FC64838DBD88 = getEnt("ascender_cable_center", "script_noteworthy");
  _id_FEF5FF64838DC421 show();
  _id_FEF5FC64838DBD88 show();
}

_id_5F81C65CD201B6FB(_id_CA6C977557F7F7D8) {
  _id_D28E92484F3D9482 = scripts\engine\utility::getStruct("ascender_marker_" + _id_CA6C977557F7F7D8, "script_noteworthy");
}

_id_BFF5C2828D6ECED0(_id_67154D86968D5C5A) {
  _id_D2CE2FD1A4747E5C = scripts\engine\utility::getStructArray("gauntlet_dest_vfx_1", "script_noteworthy");
  _id_71409825AAEB160D = scripts\engine\utility::getStructArray("gauntlet_dest_vfx_2", "script_noteworthy");

  switch (_id_67154D86968D5C5A) {
    case 1:
      _id_A3957180D1257DE9("gauntlet_dest_1", _id_D2CE2FD1A4747E5C);
      _id_D9955353B696E95A("gauntlet_create_1");
      break;
    case 2:
      _id_A3957180D1257DE9("gauntlet_dest_1", _id_D2CE2FD1A4747E5C);
      _id_A3957180D1257DE9("gauntlet_dest_2", _id_71409825AAEB160D);
      _id_D9955353B696E95A("gauntlet_create_2");

      if(isDefined(level._id_6B0323665696A1C2)) {
        foreach(model in level._id_6B0323665696A1C2)
        model delete();
      }

      level thread _id_78F63BA7F4B7A9DB::_id_9E25C98AFACDDEB8();
    default:
      break;
  }

  level thread _id_44D1054D05BBE42C();

  foreach(player in level.players)
  player thread _id_721F01B9DF408A53(&"CP_HARRIER_BOSS/GAUNTLET_DESTROYED");
}

_id_44D1054D05BBE42C() {
  level endon("game_ended");

  if(!isDefined(level._id_29EADCE247BA9D18)) {
    _id_18AF78602B67B70C::_id_2191D00EC620E904("rooftop_1");

    if(isDefined(level._id_BC2EC152B6EC2F34))
      level._id_BC2EC152B6EC2F34 delete();
  }

  if(!isDefined(level._id_29EADFE247BAA3B1)) {
    _id_18AF78602B67B70C::_id_2191D00EC620E904("rooftop_2");

    if(isDefined(level._id_BC2EC452B6EC35CD))
      level._id_BC2EC452B6EC35CD delete();
  }

  if(!isDefined(level._id_29EADEE247BAA17E)) {
    _id_18AF78602B67B70C::_id_2191D00EC620E904("rooftop_3");

    if(isDefined(level._id_BC2EC352B6EC339A))
      level._id_BC2EC352B6EC339A delete();
  }

  if(!isDefined(level._id_DCF829B6983D5EFB)) {
    _id_18AF78602B67B70C::_id_2191D00EC620E904("left");

    if(isDefined(level._id_6E8C862706AE5F67))
      level._id_6E8C862706AE5F67 delete();
  }

  if(!isDefined(level._id_97C8310BBE694643)) {
    _id_18AF78602B67B70C::_id_2191D00EC620E904("center");

    if(isDefined(level._id_E1317D0C528B53FF))
      level._id_E1317D0C528B53FF delete();
  }

  if(!isDefined(level._id_D6D25B63A5C65344)) {
    _id_18AF78602B67B70C::_id_2191D00EC620E904("right");

    if(isDefined(level._id_BC03C4DEAA9C1918))
      level._id_BC03C4DEAA9C1918 delete();
  }
}

_id_CA5156FDFAF80A9D() {
  _id_776083776F6F0302 = scripts\engine\utility::getStruct("TBreceptortest", "script_noteworthy");
  _id_16681359F6E957F8 = spawn("script_model", _id_776083776F6F0302.origin);
  _id_16681359F6E957F8 setModel("container_barrel_uranium_closed_01");
  _id_7E1F3A5AA9B072AF::_id_E845B7F0B2F4B71A(_id_16681359F6E957F8, "tag_origin", ::_id_CC2B39ED44874BE9, 1, 512);
}

_id_CC2B39ED44874BE9() {}

_id_4638A8FA685D555D() {
  _id_776083776F6F0302 = scripts\engine\utility::getStruct("gauntlet_blocker_str", "script_noteworthy");
  _id_16681359F6E957F8 = _id_776083776F6F0302 scripts\engine\utility::spawn_tag_origin();
  _id_16681359F6E957F8 setModel("offhand_wm_trophy_system");
  _id_7E1F3A5AA9B072AF::_id_E845B7F0B2F4B71A(_id_16681359F6E957F8, "tag_origin", ::_id_1DAA8686B83E3277, 0, 512);
  level thread _id_CE68EA30EC66A179(_id_776083776F6F0302.origin, &"CP_HARRIER_BOSS/TB_DESTROY");
}

_id_CE68EA30EC66A179(_id_6F74398C38C8F660, _id_016487A606317A5D) {
  level endon("game_ended");
  level endon("gauntlet_blocker_exploded");

  for(;;) {
    foreach(player in level.players)
    player thread _id_EB7EDD01A2435A69(_id_6F74398C38C8F660);

    wait 1;
  }
}

_id_EB7EDD01A2435A69(_id_F70D4483879DCA99) {
  player = self;
  level endon("game_ended");
  player endon("death");
  player endon("disconnect");

  if(istrue(player._id_7F39DF8D47BEA188)) {
    return;
  }
  _id_74A097EBC9DAF4FC = abs(player.origin[2] - _id_F70D4483879DCA99[2]);

  if(_id_74A097EBC9DAF4FC > 128 || distance2d(player.origin, _id_F70D4483879DCA99) > 128) {
    return;
  }
  player._id_7F39DF8D47BEA188 = 1;
  player scripts\cp\cp_hud_message::tutorialprint(&"CP_HARRIER_BOSS/TB_DESTROY", 2);
  wait 2;
  player._id_7F39DF8D47BEA188 = undefined;
}

_id_43CD833F1EE643BA() {
  _id_32595262B98E6F31 = getEnt("gauntlet_blocker", "script_noteworthy");

  if(isDefined(_id_32595262B98E6F31))
    _id_32595262B98E6F31 delete();
}

_id_1DAA8686B83E3277() {
  _id_32595262B98E6F31 = getEnt("gauntlet_blocker", "script_noteworthy");
  _id_32595262B98E6F31 delete();
  level notify("gauntlet_blocker_exploded");
}

_id_2F239C4E525468FD(vehicle) {
  _id_918C5A31037E00EE = spawnStruct();
  _id_918C5A31037E00EE.script_airresistance = 1;
  _id_918C5A31037E00EE.speed = 50;
  _id_918C5A31037E00EE.script_accel = 6;
  _id_918C5A31037E00EE.script_decel = 6;
  vehicle._id_918C5A31037E00EE = _id_918C5A31037E00EE;
}

_id_FF6D29A53FB9149A(index) {
  level.spawn_infil_lbravo = ::_id_2F239C4E525468FD;

  if(_id_C4290C38B7A644B6()) {
    _id_72DAC79A97FC7C5C = scripts\engine\utility::getStruct("heli_infils_" + index, "script_noteworthy");

    if(!isDefined(_id_72DAC79A97FC7C5C)) {
      return;
    }
    spawners = scripts\engine\utility::getStructArray("heli_squad_" + index, "targetname");
    scripts\cp\cp_spawning_util::_id_94E3A9862B435632(_id_72DAC79A97FC7C5C, spawners);
  }
}

_id_0B92FFD99312848A() {
  level endon("game_ended");
  player = level.players[0];

  for(;;) {
    player waittill("last_stand");
    wait 5;
    player _id_0AFB7E332AEE4BF2::instant_revive(player);
    wait 1;
  }
}

_id_0399D2147C9F8928() {
  _id_5A6441C2F58DB8AF = 0;

  if(getdvarint("dvar_D7E076076EC1F2BB", 0))
    return 1;

  if(getdvarint("dvar_212A4562911DD530", 0)) {
    foreach(player in level.players)
    level thread _id_76BAE8816C808015(player);
  }

  if(getdvarint("dvar_FF3F6C2CCE082B60", 0) > 0) {
    for(;;) {
      wait 5;
      _id_D96E070433D9444B();
      level waittill("shieldAI_dead");
    }
  }

  if(getdvarint("dvar_F2A529453E2E8BE7", 0) > 0) {
    wait 5;
    marker = scripts\engine\utility::getStruct("gauntlet_lower_center", "script_noteworthy");
    streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("white_phosphorus", level.players[0]);
    _id_470C049A636DB53D = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
      _id_470C049A636DB53D[_id_AC0E594AC96AA3A8] = spawnStruct();
      _id_470C049A636DB53D[_id_AC0E594AC96AA3A8].location = marker.origin;
      _id_470C049A636DB53D[_id_AC0E594AC96AA3A8].angles = 0;
    }

    level.players[0] thread scripts\cp_mp\killstreaks\white_phosphorus::wp_startdeploy(_id_470C049A636DB53D, streakinfo);
    _id_5A6441C2F58DB8AF = 1;
  } else if(getdvarint("dvar_4CA30CA85D403046", 0) > 0) {
    level thread _id_0B92FFD99312848A();
    level _id_34D2771929BD6022::_id_45A5AEEB6A2CD77B("test2manDoor");
    _id_5A6441C2F58DB8AF = 1;
  } else if(getdvarint("dvar_D0818A068B915C19", 0) > 0) {
    _id_E96C03F131DD6DB2();
    _id_5A6441C2F58DB8AF = 1;
  } else if(getdvarint("dvar_55E4BC197165E614", 0))
    level thread _id_BCCEAE8D78EB76CA();
  else if(getdvarint("dvar_78F41F36FD3BF04A", 0) > 0 || getdvarint("dvar_7F4B5C5CBF6FC4CC", 0) > 0) {
    wait 4;
    _id_92720692FFB59573();
    _id_5A6441C2F58DB8AF = 1;
  }

  return _id_5A6441C2F58DB8AF;
}

_id_45E7F23613B3B7A0(_id_E835BD5EBF3BA5EB) {
  level endon("game_ended");
  wait 2;

  if(istrue(_id_E835BD5EBF3BA5EB))
    _id_1C20DB623BDAC8A3(0);
  else {
    thread _id_5E0F7D6E1DF0562A();
    _id_1C20DB623BDAC8A3(1);
  }

  level thread _id_18AF78602B67B70C::_id_EA91746731D2AC2D();
  _id_5A6441C2F58DB8AF = _id_0399D2147C9F8928();

  if(istrue(_id_5A6441C2F58DB8AF)) {
    return;
  }
  if(!istrue(_id_E835BD5EBF3BA5EB)) {
    if(getdvarint("dvar_9BF25E3C9D39E8EA", 0) == 0) {
      level thread _id_5AD390012341F977();
      level thread _id_CA5D7791980E307B();
    }

    level waittill("gauntlet_burst_spawn");

    if(getdvarint("dvar_9BF25E3C9D39E8EA", 0) == 0)
      level thread _id_BCCEAE8D78EB76CA();
  } else {
    level waittill("players_teleported_into_battle");

    if(getdvarint("dvar_9BF25E3C9D39E8EA", 0) == 0) {
      level thread _id_CA5D7791980E307B();
      level thread _id_BCCEAE8D78EB76CA();
    }

    _id_92720692FFB59573(1);
  }
}

_id_A490A49AA45906C7() {
  level endon("game_ended");
  _id_9A194154F62D1BDC = self;
  _id_9A194154F62D1BDC scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_HARRIER_BOSS/TEST_PROMPT", 25, "duration_medium", "hide", 256, 65, 64, 65);

  for(;;) {
    _id_9A194154F62D1BDC _meth_DFB78B3E724AD620(1);
    _id_9A194154F62D1BDC waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    _id_9A194154F62D1BDC _meth_DFB78B3E724AD620(0);
    _id_EC01360148163158();
    wait 3;
  }
}

_id_EC01360148163158() {
  level notify("players_teleported_into_battle");
  _id_92C4DE821390F609 = "";

  if(!isDefined(level._id_AD9B99883D277045))
    level._id_AD9B99883D277045 = "pipe_room";

  switch (level._id_AD9B99883D277045) {
    case "pipe_room":
    default:
      _id_92C4DE821390F609 = "pipe_room_playerstart";
      break;
    case "gauntlet_approach":
      _id_92C4DE821390F609 = "harrier_battle_plrstart";
      break;
    case "vtol_fight":
      _id_92C4DE821390F609 = "harrier_ph1_plrstart";
      break;
  }

  destinations = scripts\engine\utility::getStructArray(_id_92C4DE821390F609, "script_noteworthy");
  players = level.players;
  _id_4261D280BB619EF4 = scripts\engine\utility::getStruct("starting_room_marker", "script_noteworthy");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    if(distance2d(players[_id_AC0E594AC96AA3A8].origin, _id_4261D280BB619EF4.origin) <= 512) {
      players[_id_AC0E594AC96AA3A8].scriptedattackeraccuracy = 1.5;
      players[_id_AC0E594AC96AA3A8].attackeraccuracy = 1;
      players[_id_AC0E594AC96AA3A8] setOrigin(destinations[_id_AC0E594AC96AA3A8].origin);
      players[_id_AC0E594AC96AA3A8] setplayerangles(scripts\engine\utility::ter_op(isDefined(destinations[_id_AC0E594AC96AA3A8].angles), destinations[_id_AC0E594AC96AA3A8].angles, (0, 0, 0)));
      scripts\cp\cp_grenade_crate::refill_grenades(players[_id_AC0E594AC96AA3A8]);
      _id_BC9DA38A4BAB4CE2 = players[_id_AC0E594AC96AA3A8] getweaponslistprimaries();

      foreach(weapon in _id_BC9DA38A4BAB4CE2)
      players[_id_AC0E594AC96AA3A8] _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(weapon);
    }
  }
}

_id_375400F1A557A500(player) {
  player._id_2D1F8B5D21B0710A = 1;
  player scripts\cp\utility::allow_player_basejumping(1, "harrier_boss_parachute_given");
  player skydive_cutparachuteon();
  player setclientomnvar("ui_parachuteicon", 1);
}

_id_B9AF409472480645(player) {
  player._id_2D1F8B5D21B0710A = 0;
  player scripts\cp\utility::allow_player_basejumping(0, "harrier_boss_parachute_given");
  player skydive_cutparachuteoff();
  player setclientomnvar("ui_parachuteicon", 0);
}

_id_7F903703F7242747(_id_F8E5E3AA5762A8E7) {
  spawners = _id_18A73A64992DD07D::process_module_var(_id_F8E5E3AA5762A8E7, _id_F8E5E3AA5762A8E7.spawn_points);
  _id_F8E5E3AA5762A8E7.totalspawns = spawners.size;
  return spawners.size;
}

_id_E50E2F5C89F7F71F(_id_F8E5E3AA5762A8E7) {
  spawners = _id_18A73A64992DD07D::process_module_var(_id_F8E5E3AA5762A8E7, _id_F8E5E3AA5762A8E7.spawn_points);
  _id_F8E5E3AA5762A8E7.max_size = spawners.size;
  return spawners.size;
}

_id_712E3A2DF3F5096E(_id_F8E5E3AA5762A8E7) {}

_id_74029165F1B9193E(event) {
  self.goalradius = 1024;
  scripts\stealth\utility::set_event_override("combat", undefined);
  scripts\stealth\utility::set_event_override("cover_blown", undefined);
  return 0;
}

register_spawners() {
  wait 1;
  scripts\engine\utility::flag_wait("cp_raid1test_create_script2_completed");
  scripts\engine\utility::flag_wait("cp_raid1test_create_script_completed");
  _id_18A73A64992DD07D::registerambientgroup("pilot_spawner", 1, 1, 1, undefined, undefined, "pilot_spawner");
  _id_18A73A64992DD07D::register_module_ai_spawn_func("pilot_spawner", ::_id_C0CF992D5D2499EE);
  _id_18A73A64992DD07D::registerambientgroup("test_shield", 1, 1, 1, undefined, undefined, "shieldtest");
  _id_18A73A64992DD07D::registerambientgroup("planterTest", 1, 1, 1, undefined, undefined, "planterTest");
  _id_18A73A64992DD07D::register_module_ai_spawn_func("planterTest", ::_id_DB96ADEFD434D3CA);
  _id_18A73A64992DD07D::registerambientgroup("planter_right", 1, 1, 1, undefined, undefined, "planter_right");
  _id_18A73A64992DD07D::register_module_ai_spawn_func("planter_right", ::_id_DB96ADEFD434D3CA);
  _id_18A73A64992DD07D::registerambientgroup("planter_left", 1, 1, 1, undefined, undefined, "planter_left");
  _id_18A73A64992DD07D::register_module_ai_spawn_func("planter_left", ::_id_DB96ADEFD434D3CA);
  _id_18A73A64992DD07D::registerambientgroup("planter_armor_right", 1, 1, 1, undefined, undefined, "planter_armor_right");
  _id_18A73A64992DD07D::register_module_ai_spawn_func("planter_armor_right", ::_id_DB96ADEFD434D3CA);
  _id_18A73A64992DD07D::registerambientgroup("planter_armor_left", 1, 1, 1, undefined, undefined, "planter_armor_left");
  _id_18A73A64992DD07D::register_module_ai_spawn_func("planter_armor_left", ::_id_DB96ADEFD434D3CA);
  _id_18A73A64992DD07D::registerambientgroup("backplanter_right", 1, 1, 1, undefined, undefined, "backplanter_right");
  _id_18A73A64992DD07D::register_module_ai_spawn_func("backplanter_right", ::_id_DB96ADEFD434D3CA);
  _id_18A73A64992DD07D::registerambientgroup("backplanter_left", 1, 1, 1, undefined, undefined, "backplanter_left");
  _id_18A73A64992DD07D::register_module_ai_spawn_func("backplanter_left", ::_id_DB96ADEFD434D3CA);
  _id_18A73A64992DD07D::registerambientgroup("bomber_jugg_left", 1, 1, 1, undefined, undefined, "bomber_jugg_left");
  _id_18A73A64992DD07D::register_module_ai_spawn_func("bomber_jugg_left", ::_id_FA26F636F954C88D);
  _id_18A73A64992DD07D::registerambientgroup("bomber_jugg_right", 1, 1, 1, undefined, undefined, "bomber_jugg_right");
  _id_18A73A64992DD07D::register_module_ai_spawn_func("bomber_jugg_right", ::_id_FA26F636F954C88D);
  _id_18A73A64992DD07D::registerambientgroup("samsite_grenadiers", 2, 2, 2, undefined, undefined, "smg_1_B");
  _id_18A73A64992DD07D::register_module_ai_spawn_func("samsite_grenadiers", ::_id_3B16BE21D4A55959);
  _id_18A73A64992DD07D::registerambientgroup("riotshield_1", 1, 1, 1, undefined, undefined, "riotshield_1");
  _id_18A73A64992DD07D::register_module_ai_spawn_func("riotshield_1", ::_id_77D26A351FE76622);
  _id_18A73A64992DD07D::registerambientgroup("shieldsupport_1", 3, 3, 3, 1, undefined, "shieldsupport_1");
  _id_18A73A64992DD07D::register_module_ai_spawn_func("shieldsupport_1", ::_id_4B40FB0D906099D5);
  _id_18A73A64992DD07D::registerambientgroup("riotshield_2", 1, 1, 1, undefined, undefined, "riotshield_2");
  _id_18A73A64992DD07D::register_module_ai_spawn_func("riotshield_2", ::_id_77D26A351FE76622);
  _id_18A73A64992DD07D::registerambientgroup("shieldsupport_2", 3, 3, 3, 1, undefined, "shieldsupport_2");
  _id_18A73A64992DD07D::register_module_ai_spawn_func("shieldsupport_2", ::_id_4B40FB0D906099D5);
  _id_18A73A64992DD07D::registerambientgroup("heli_infils_2", 0, ::_id_E50E2F5C89F7F71F, ::_id_7F903703F7242747, undefined, undefined, "heli_infils_2");
  _id_18A73A64992DD07D::register_module_ai_spawn_func("heli_infils_2", ::_id_5E2626E8DB4DC57C);
  _id_18A73A64992DD07D::registerambientgroup("heli_infils_4", 0, ::_id_E50E2F5C89F7F71F, ::_id_7F903703F7242747, undefined, undefined, "heli_infils_4");
  _id_18A73A64992DD07D::register_module_ai_spawn_func("heli_infils_4", ::_id_5E2626E8DB4DC57C);
  _id_18A73A64992DD07D::registerambientgroup("firstcontact", 0, ::_id_E50E2F5C89F7F71F, ::_id_7F903703F7242747, undefined, undefined, "firstcontact");
  _id_18A73A64992DD07D::registerambientgroup("intro_1", 0, ::_id_E50E2F5C89F7F71F, ::_id_7F903703F7242747, undefined, undefined, "intro_1");
  _id_18A73A64992DD07D::registerambientgroup("intro_2", 0, ::_id_E50E2F5C89F7F71F, ::_id_7F903703F7242747, undefined, undefined, "intro_2");
  _id_18A73A64992DD07D::registerambientgroup("intro_3", 0, ::_id_E50E2F5C89F7F71F, ::_id_7F903703F7242747, undefined, undefined, "intro_3");
  _id_18A73A64992DD07D::registerambientgroup("intro_gauntlet", 0, ::_id_E50E2F5C89F7F71F, ::_id_7F903703F7242747, undefined, undefined, "intro_gauntlet");
  _id_18A73A64992DD07D::registerambientgroup("bunker_ai", 0, ::_id_E50E2F5C89F7F71F, ::_id_7F903703F7242747, undefined, undefined, "bunker_ai");
  _id_18A73A64992DD07D::register_module_ai_spawn_func("firstcontact", ::_id_712E3A2DF3F5096E);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_1", ::_id_712E3A2DF3F5096E);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_2", ::_id_712E3A2DF3F5096E);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_3", ::_id_712E3A2DF3F5096E);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("intro_gauntlet", ::_id_712E3A2DF3F5096E);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("bunker_ai", ::_id_712E3A2DF3F5096E);
  _id_CD14F701C8F2214E = 1;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 5; _id_AC0E594AC96AA3A8++) {
    _id_18A73A64992DD07D::registerambientgroup("ar_" + _id_AC0E594AC96AA3A8 + "_A", _id_CD14F701C8F2214E, _id_CD14F701C8F2214E, _id_CD14F701C8F2214E, 0.1, undefined, "ar_" + _id_AC0E594AC96AA3A8 + "_A", undefined, undefined, undefined);
    _id_18A73A64992DD07D::registerambientgroup("ar_" + _id_AC0E594AC96AA3A8 + "_B", _id_CD14F701C8F2214E, _id_CD14F701C8F2214E, _id_CD14F701C8F2214E, 0.1, undefined, "ar_" + _id_AC0E594AC96AA3A8 + "_B", undefined, undefined, undefined);
    _id_18A73A64992DD07D::registerambientgroup("smg_" + _id_AC0E594AC96AA3A8 + "_A", _id_CD14F701C8F2214E, _id_CD14F701C8F2214E, _id_CD14F701C8F2214E, 0.1, undefined, "smg_" + _id_AC0E594AC96AA3A8 + "_A", undefined, undefined, undefined);
    _id_18A73A64992DD07D::registerambientgroup("smg_" + _id_AC0E594AC96AA3A8 + "_B", _id_CD14F701C8F2214E, _id_CD14F701C8F2214E, _id_CD14F701C8F2214E, 0.1, undefined, "smg_" + _id_AC0E594AC96AA3A8 + "_B", undefined, undefined, undefined);
    _id_18A73A64992DD07D::registerambientgroup("shotgun_" + _id_AC0E594AC96AA3A8 + "_A", _id_CD14F701C8F2214E, _id_CD14F701C8F2214E, _id_CD14F701C8F2214E, 0.1, undefined, "shotgun_" + _id_AC0E594AC96AA3A8 + "_A", undefined, undefined, undefined);
    _id_18A73A64992DD07D::registerambientgroup("shotgun_" + _id_AC0E594AC96AA3A8 + "_B", _id_CD14F701C8F2214E, _id_CD14F701C8F2214E, _id_CD14F701C8F2214E, 0.1, undefined, "shotgun_" + _id_AC0E594AC96AA3A8 + "_B", undefined, undefined, undefined);
    _id_18A73A64992DD07D::registerambientgroup("jugg_" + _id_AC0E594AC96AA3A8, 1, 1, 1, 0.1, undefined, "jugg_" + _id_AC0E594AC96AA3A8, undefined, undefined, undefined);
    _id_18A73A64992DD07D::register_module_ai_spawn_func("ar_" + _id_AC0E594AC96AA3A8 + "_A", ::_id_5E2626E8DB4DC57C);
    _id_18A73A64992DD07D::register_module_ai_spawn_func("ar_" + _id_AC0E594AC96AA3A8 + "_B", ::_id_5E2626E8DB4DC57C);
    _id_18A73A64992DD07D::register_module_ai_spawn_func("smg_" + _id_AC0E594AC96AA3A8 + "_A", ::_id_5E2626E8DB4DC57C);
    _id_18A73A64992DD07D::register_module_ai_spawn_func("smg_" + _id_AC0E594AC96AA3A8 + "_B", ::_id_5E2626E8DB4DC57C);
    _id_18A73A64992DD07D::register_module_ai_spawn_func("shotgun_" + _id_AC0E594AC96AA3A8 + "_A", ::_id_5E2626E8DB4DC57C);
    _id_18A73A64992DD07D::register_module_ai_spawn_func("shotgun_" + _id_AC0E594AC96AA3A8 + "_B", ::_id_5E2626E8DB4DC57C);
    _id_18A73A64992DD07D::register_module_ai_spawn_func("jugg_" + _id_AC0E594AC96AA3A8, ::_id_764A73CCEE6008BA);
  }

  _id_18A73A64992DD07D::registerambientgroup("gauntlet_trickle_sniper_1", 1, 1, 1, 0.1, undefined, "gauntlet_trickle_sniper_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("gauntlet_trickle_sniper_2", 1, 1, 1, 0.1, undefined, "gauntlet_trickle_sniper_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("gauntlet_trickle_sniper_1", ::_id_5F70DB8E1A39E688);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("gauntlet_trickle_sniper_2", ::_id_5F70DB8E1A39E688);
  _id_E612D6C820B7EBB2 = 3;
  _id_18A73A64992DD07D::registerambientgroup("gauntlet_ledge_spawner", _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, 0.1, undefined, "gauntlet_ledge_spawner", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("gauntlet_left_room_3", _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, 0.1, undefined, "gauntlet_left_room_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("gauntlet_left_room_1", _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, 0.1, undefined, "gauntlet_left_room_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("gauntlet_left_room_2", _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, 0.1, undefined, "gauntlet_left_room_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("gauntlet_right_room_1", _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, 0.1, undefined, "gauntlet_right_room_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("gauntlet_right_room_2", _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, 0.1, undefined, "gauntlet_right_room_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("gauntlet_right_room_3", _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, 0.1, undefined, "gauntlet_right_room_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("ambush_ledge_left", _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, 0.1, undefined, "ambush_ledge_left", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("gauntlet_center", _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, 0.1, undefined, "gauntlet_center", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("gauntlet_center_1", _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, 0.1, undefined, "gauntlet_center_1", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("gauntlet_center_2", _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, 0.1, undefined, "gauntlet_center_2", undefined, undefined, undefined);
  _id_18A73A64992DD07D::registerambientgroup("gauntlet_roof", _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, _id_E612D6C820B7EBB2, 0.1, undefined, "gauntlet_roof", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("gauntlet_ledge_spawner", ::_id_AA12BC653546F52C);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("gauntlet_left_room_3", ::_id_A38200D99A8364A6);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("gauntlet_left_room_1", ::_id_A38200D99A8364A6);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("gauntlet_left_room_2", ::_id_A38200D99A8364A6);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("gauntlet_right_room_1", ::_id_A38200D99A8364A6);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("gauntlet_right_room_2", ::_id_A38200D99A8364A6);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("gauntlet_right_room_3", ::_id_A38200D99A8364A6);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("ambush_ledge_left", ::_id_AA12BC653546F52C);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("gauntlet_center", ::_id_A38200D99A8364A6);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("gauntlet_center_1", ::_id_A38200D99A8364A6);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("gauntlet_center_2", ::_id_A38200D99A8364A6);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("gauntlet_roof", ::_id_A38200D99A8364A6);
}

_id_DB96ADEFD434D3CA(group) {
  if(issubstr(self.aitype, "_laser")) {
    _id_18A73A64992DD07D::give_soldier_armor();
    _id_18A73A64992DD07D::give_soldier_helmet();
    self.equip_armor = 1;
    self._id_B5218CF00DAD94EF = 240;
  }

  _id_4F2A0297830D644C = strtok(group.group_name, "_");
  _id_92C4DE821390F609 = "bomber_point_" + _id_4F2A0297830D644C[_id_4F2A0297830D644C.size - 1];
  thread _id_3F3AB06505AA7C46::_id_E96CD5024F2AC563(group, _id_92C4DE821390F609);
}

_id_3B16BE21D4A55959(group) {
  thread _id_CE6764A5678CC442();
}

_id_FA26F636F954C88D(group) {
  if(!isDefined(level._id_1DC7D5C54BA2D06E))
    level._id_1DC7D5C54BA2D06E = [];

  level._id_1DC7D5C54BA2D06E[level._id_1DC7D5C54BA2D06E.size] = self;
  _id_9743A24AC8368484 = 200;
  self aisetdesiredspeed(_id_9743A24AC8368484);
  self aisettargetspeed(_id_9743A24AC8368484);
  self.maxhealth = 4000;
  self.health = 4000;
  _id_4F2A0297830D644C = strtok(group.group_name, "_");
  _id_92C4DE821390F609 = "bomber_point_" + _id_4F2A0297830D644C[_id_4F2A0297830D644C.size - 1];
  thread _id_3F3AB06505AA7C46::_id_E96CD5024F2AC563(group, _id_92C4DE821390F609, 15);
  level thread _id_81AD1BB1DF3BDDD9(self);
}

_id_81AD1BB1DF3BDDD9(_id_E21279FA90BDF012) {
  level endon("game_ended");
  level endon("vtol_destroyed");
  result = _id_E21279FA90BDF012 scripts\engine\utility::waittill_any_return_2("death", "bomb_planted");

  if(result == "death")
    scripts\engine\utility::array_remove(level._id_1DC7D5C54BA2D06E, _id_E21279FA90BDF012);

  if(result == "bomb_planted")
    _id_E21279FA90BDF012._id_49066A0E2A3EAEF9 = 1;
}

_id_AA12BC653546F52C(group) {
  waitframe();

  if(issubstr(self.aitype, "_laser")) {
    _id_18A73A64992DD07D::give_soldier_armor();
    _id_18A73A64992DD07D::give_soldier_helmet();
    self.equip_armor = 1;
    self._id_B5218CF00DAD94EF = 240;
  }
}

_id_A38200D99A8364A6(group) {
  waitframe();
  self.goalradius = 128;
  self.maxsightdistsqrd = 65536;
  self.baseaccuracy = 0.5;

  if(issubstr(self.aitype, "_laser")) {
    _id_18A73A64992DD07D::give_soldier_armor();
    _id_18A73A64992DD07D::give_soldier_helmet();
    self.equip_armor = 1;
    self._id_B5218CF00DAD94EF = 240;
  }

  thread _id_93FEE879A6F326EB();
}

_id_93FEE879A6F326EB() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    targetplayer = _id_B09E4B411E17684B();

    if(isDefined(targetplayer) && isalive(targetplayer)) {
      self.goalradius = 128;
      _id_5357ACDB76B0BD75 = abs(self.origin[2] - targetplayer.origin[2]);

      if(_id_5357ACDB76B0BD75 > 150)
        wait(randomintrange(4, 8));

      self.favoritenemy = targetplayer;
      self setgoalentity(targetplayer);
    } else
      self.goalradius = 256;

    wait 10;
  }
}

_id_B09E4B411E17684B() {
  foreach(player in level.players) {
    if(_id_A387A3A903F7DF2D("gauntlet_trigger", player))
      return player;
  }

  return undefined;
}

_id_5F70DB8E1A39E688(group) {
  _id_3500C035FF65C901 = "iw8_sn_alpha50_mp+ammomod_wound+bipodsnpr|1+flashhidersnpr_alpha50|1+iw8_back_alpha50|3+iw8_front_alpha50|3+iw8_mag_alpha50|3+iw8_rec_alpha50|3+pistolgrip01_alpha50|2+snprscope_alpha50|2+loot3";
  _id_FA2483033790AF38 = makeweaponfromstring(_id_3500C035FF65C901);

  if(isDefined(self.weapon))
    self takeweapon(self.weapon);

  self.weapon = _id_FA2483033790AF38;
  scripts\common\utility::initweapon(self.weapon);
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  _id_4F04B9C326EB7400 = "iw9_pi_papa220_mp, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_4F04B9C326EB7400]))
    level._id_67B54180A55F70E1[_id_4F04B9C326EB7400] = scripts\cp\cp_weapon::_id_E83615F8A92E4378("iw9_pi_papa220_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");

  self.sidearm = level._id_67B54180A55F70E1[_id_4F04B9C326EB7400];
  scripts\common\utility::initweapon(self.sidearm);
}

_id_FEFFF66D309D4C06(group, ai) {
  level endon("game_ended");
  ai waittill("death");
  level scripts\engine\utility::waittill_any_timeout_1(50, "spawn_gauntlet_snipers");
  level thread _id_18A73A64992DD07D::run_spawn_module(group.group_name);
}

_id_77D26A351FE76622(group) {
  level._id_97E70F016F42963B = self;
  self.follow_ents = [];
  _id_6201975F5678AB96 = 3;
  _id_9743A24AC8368484 = 50;
  self aisetdesiredspeed(_id_9743A24AC8368484);
  self aisettargetspeed(_id_9743A24AC8368484);
  self._id_894D1167ACE5B58C = 1;
  self._id_7361FDEEBF3A4B92 = 1;
  self.scripted_mode = 1;
  self._id_C833409FB72D15FB = 1;
  offset = 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 <= _id_6201975F5678AB96; _id_AC0E594AC96AA3A8++) {
    self.follow_ents[_id_AC0E594AC96AA3A8] = scripts\engine\utility::spawn_tag_origin();
    self.follow_ents[_id_AC0E594AC96AA3A8].origin = self.follow_ents[_id_AC0E594AC96AA3A8].origin + anglesToForward(self.angles) * (-50 * offset);
    self.follow_ents[_id_AC0E594AC96AA3A8] linkTo(self, "tag_origin");
    self.follow_ents[_id_AC0E594AC96AA3A8]._id_920B9F526292343D = 0;
    offset++;
  }

  _id_137CC0FFDF383E20 = scripts\engine\utility::getclosest(self.origin, level.players);

  if(isDefined(_id_137CC0FFDF383E20) && isPlayer(_id_137CC0FFDF383E20))
    self setgoalentity(_id_137CC0FFDF383E20);

  thread _id_168FC70787DABB09(6);
  thread _id_8E83CD217282CF59(120, self);
  level thread _id_E8202A4F7AFDB322(self, self.follow_ents);
}

_id_E8202A4F7AFDB322(_id_F84AC2CCB7921242, _id_1587516C91B9F996) {
  level endon("game_ended");
  _id_F84AC2CCB7921242 waittill("death");
  level._id_97E70F016F42963B = undefined;

  foreach(_id_90F9773EF140E661 in _id_1587516C91B9F996) {
    if(isDefined(_id_90F9773EF140E661._id_F85572CD5F6117C6) && isai(_id_90F9773EF140E661._id_F85572CD5F6117C6)) {
      _id_90F9773EF140E661._id_F85572CD5F6117C6 notify("shieldAI_died");
      _id_90F9773EF140E661._id_F85572CD5F6117C6 thread _id_9070171775A27600();
    }

    _id_90F9773EF140E661 delete();
  }

  if(isDefined(self._id_5F25D11CACE22073)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_5F25D11CACE22073.size; _id_AC0E594AC96AA3A8++)
      despawncovernode(self._id_5F25D11CACE22073[_id_AC0E594AC96AA3A8]);
  }

  level notify("shieldAI_dead");
}

_id_CEF4598442B4B451(ai) {
  if(!isDefined(level._id_97E70F016F42963B))
    return undefined;

  _id_F84AC2CCB7921242 = level._id_97E70F016F42963B;

  foreach(_id_90F9773EF140E661 in _id_F84AC2CCB7921242.follow_ents) {
    if(!istrue(_id_90F9773EF140E661._id_2C0E6722B7883E04)) {
      _id_90F9773EF140E661._id_2C0E6722B7883E04 = 1;
      _id_90F9773EF140E661._id_F85572CD5F6117C6 = ai;
      return _id_90F9773EF140E661;
    }
  }
}

_id_4B40FB0D906099D5(group) {
  thread _id_D6798B2FEC6D1130();
}

_id_D6798B2FEC6D1130() {
  self endon("death");
  self notify("shieldAI_died");
  level endon("game_ended");
  _id_9743A24AC8368484 = 150;
  self aisetdesiredspeed(_id_9743A24AC8368484);
  self aisettargetspeed(_id_9743A24AC8368484);

  while(!isDefined(level._id_97E70F016F42963B))
    wait 1;

  _id_90F9773EF140E661 = _id_CEF4598442B4B451(self);
  self.goalradius = 64;
  self setgoalentity(_id_90F9773EF140E661);
}

_id_C0CF992D5D2499EE(group) {
  level._id_5174DA4EE87ECB7B = self;
  self.goalradius = 30;
  self.dont_enter_combat = 1;
  self.dontevershoot = 1;
  self.ignoreall = 1;
  self.scripted_mode = 1;
}

_id_764A73CCEE6008BA(group) {
  _id_9743A24AC8368484 = 220;
  self aisetdesiredspeed(_id_9743A24AC8368484);
  self aisettargetspeed(_id_9743A24AC8368484);
}

_id_5E2626E8DB4DC57C(group) {
  self.goalradius = 128;
  thread _id_D4AB76E9D679AC45(group);
  self.maxsightdistsqrd = 65536;
  self.baseaccuracy = 0.45;

  if(issubstr(self.aitype, "_laser")) {
    _id_18A73A64992DD07D::give_soldier_armor();
    _id_18A73A64992DD07D::give_soldier_helmet();
    self.equip_armor = 1;
    self._id_B5218CF00DAD94EF = 210;
  }

  _id_137CC0FFDF383E20 = scripts\engine\utility::getclosest(self.origin, level.players);

  if(isDefined(_id_137CC0FFDF383E20) && isPlayer(_id_137CC0FFDF383E20)) {
    self setgoalentity(_id_137CC0FFDF383E20);
    _id_4F2A0297830D644C = strtok(group.group_name, "_");

    switch (_id_4F2A0297830D644C[0]) {
      case "ar":
        self.goalradius = 2000;
        self setengagementmindist(256.0, 0.0);
        self setengagementmaxdist(768.0, 2048.0);
        self _meth_9215CE6FC83759B9(2048);
        break;
      case "smg":
        self.goalradius = 1000;
        self setengagementmindist(256.0, 0.0);
        self setengagementmaxdist(768.0, 1024.0);
        self _meth_9215CE6FC83759B9(2048);
        break;
      case "shotgun":
        self.goalradius = 1000;
        self setengagementmindist(256.0, 0.0);
        self setengagementmaxdist(768.0, 1024.0);
        self _meth_9215CE6FC83759B9(1024);
        break;
      default:
        self.goalradius = 4096;
        self setengagementmindist(256.0, 0.0);
        self setengagementmaxdist(768.0, 1024.0);
        self _meth_9215CE6FC83759B9(0);
        break;
    }
  }

  thread _id_9070171775A27600();
}

_id_168FC70787DABB09(interval) {
  level endon("game_ended");
  self endon("death");
  _id_0548E22DF68D2E25 = scripts\engine\utility::getStructArray("ground_ai_converge", "script_noteworthy");
  _id_8EE1CE7ECCBE27E2 = 1;

  for(;;) {
    if(istrue(_id_8EE1CE7ECCBE27E2)) {
      _id_DE498D49DC2BE3B8 = _id_F14AB8184282CEE5();

      if(_id_DE498D49DC2BE3B8.size > 0) {
        _id_8EE1CE7ECCBE27E2 = 0;
        closestplayer = scripts\engine\utility::getclosest(self.origin, _id_DE498D49DC2BE3B8);
        self setgoalpos(getclosestpointonnavmesh(closestplayer.origin));
      } else
        self setgoalpos(scripts\engine\utility::random(_id_0548E22DF68D2E25).origin);
    } else {
      _id_8EE1CE7ECCBE27E2 = 1;

      if(istrue(self._id_6A71977FB785324B)) {
        self._id_894D1167ACE5B58C = 1;
        self setgoalpos(self.origin);
        _id_2DDE19FCFE9E3864();
        wait(interval);
        _id_AD5FF75622442A0B();
      }
    }

    waitframe();
  }
}

_id_2DDE19FCFE9E3864() {
  if(!isDefined(self.follow_ents)) {
    return;
  }
  if(!isDefined(self._id_5F25D11CACE22073))
    self._id_5F25D11CACE22073 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.follow_ents.size; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(self.follow_ents[_id_AC0E594AC96AA3A8]._id_F85572CD5F6117C6)) {
      continue;
    }
    origin = self.follow_ents[_id_AC0E594AC96AA3A8].origin;
    _id_8C13709EA092624D = origin + anglestoright(self.follow_ents[_id_AC0E594AC96AA3A8].angles) * 50;

    switch (_id_AC0E594AC96AA3A8) {
      case 0:
        self._id_5F25D11CACE22073[self._id_5F25D11CACE22073.size] = spawncovernode(origin, self.follow_ents[_id_AC0E594AC96AA3A8].angles, "Cover Left", 20);
        break;
      case 1:
        self._id_5F25D11CACE22073[self._id_5F25D11CACE22073.size] = spawncovernode(origin, self.follow_ents[_id_AC0E594AC96AA3A8].angles, "Cover Right", 20);
        break;
      default:
        self._id_5F25D11CACE22073[self._id_5F25D11CACE22073.size] = spawncovernode(origin, self.follow_ents[_id_AC0E594AC96AA3A8].angles, "Cover Stand", 24);
        break;
    }

    self._id_5F25D11CACE22073[self._id_5F25D11CACE22073.size] = spawncovernode(_id_8C13709EA092624D, self.follow_ents[_id_AC0E594AC96AA3A8].angles, "Cover Stand", 24);
  }
}

_id_AD5FF75622442A0B() {
  if(!isDefined(self._id_5F25D11CACE22073)) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_5F25D11CACE22073.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(self._id_5F25D11CACE22073[_id_AC0E594AC96AA3A8]))
      despawncovernode(self._id_5F25D11CACE22073[_id_AC0E594AC96AA3A8]);
  }
}

_id_8E83CD217282CF59(range, ai) {
  level endon("game_ended");
  ai endon("death");

  for(;;) {
    _id_E4AD905A15DB897F = undefined;

    if(isDefined(ai.enemy) && isPlayer(ai.enemy) && isalive(ai.enemy)) {
      _id_E4AD905A15DB897F = ai.enemy;
      ai._id_6A71977FB785324B = ai _id_491870A93F63A5C4(undefined, _id_E4AD905A15DB897F);
    }

    waitframe();
  }
}

_id_491870A93F63A5C4(range, player) {
  if(player scripts\cp\utility::isplayerads())
    return 0;

  range = scripts\engine\utility::_id_53C4C53197386572(range, 40);
  _id_DB0F966EEF584A38 = self gettagorigin("tag_origin");
  start = player getvieworigin();
  forward = anglesToForward(player getplayerangles());
  _id_E53C2B7666B601C4 = start + forward * 1000;
  trace = scripts\engine\trace::ray_trace_detail(start, _id_E53C2B7666B601C4, [player], level._id_65EB9D2AC62F3E5E);
  _id_E53C2B7666B601C4 = trace["position"];

  if(distance(_id_E53C2B7666B601C4, _id_DB0F966EEF584A38) > range)
    return 0;

  return 1;
}

_id_9070171775A27600() {
  level endon("game_ended");
  self endon("death");
  _id_0548E22DF68D2E25 = scripts\engine\utility::getStructArray("ground_ai_converge", "script_noteworthy");

  for(;;) {
    _id_DE498D49DC2BE3B8 = _id_F14AB8184282CEE5();

    if(_id_DE498D49DC2BE3B8.size > 0) {
      closestplayer = scripts\engine\utility::getclosest(self.origin, _id_DE498D49DC2BE3B8);
      self setgoalpos(getclosestpointonnavmesh(closestplayer.origin));
    } else
      self setgoalpos(scripts\engine\utility::random(_id_0548E22DF68D2E25).origin);

    wait 10;
  }
}

_id_7E31FC2DCF81E2A2(group) {
  level endon("game_ended");
  self waittill("death");
}

_id_D4AB76E9D679AC45(group) {
  level endon("game_ended");
  self waittill("death");

  if(randomint(100) > 10) {
    return;
  }
  _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(0, self.origin, self.angles, self);
  item = _id_66122A002AFF5D57::spawnpickup("brloot_armor_plate", _id_CB4FAD49263E20C4, 1, 1, undefined, 1);
}

_id_E96C03F131DD6DB2() {
  _id_7A678140BAD8194C = getdvarint("dvar_2F8EF4757E4AEA8F", -1);
  _id_781A10FD2196F698 = getdvarint("dvar_944397B4792D5FA6", _id_7A678140BAD8194C);
  _id_486DF7CA2FAB73DE = scripts\engine\utility::getStruct("timed_bomb_dispenser_test", "script_noteworthy");
  level._id_E1CFA96FB6789FCB = _id_7E1F3A5AA9B072AF::_id_1086536B8E7022CA(_id_486DF7CA2FAB73DE, _id_781A10FD2196F698);

  if(getdvarint("dvar_6ADE2644C7030E8A", 0) > 0) {
    _id_5424E4F6E164AA3F = scripts\engine\utility::getStructArray("TBRefresher_test", "script_noteworthy");

    foreach(_id_03B819B9C304F403 in _id_5424E4F6E164AA3F)
    _id_7E1F3A5AA9B072AF::_id_EC91ECA54AEB938D(_id_03B819B9C304F403);
  }
}

_id_92720692FFB59573(_id_F8FBA28C44387FD8) {
  if(isDefined(level._id_B3826A903E994BA3)) {
    return;
  }
  level endon("game_ended");

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");

    return 0;
  }

  _id_5FA1E1697A302583 = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
  _id_5ED27D0675C3B6EB = 24000;
  _id_23122E7B902F2EA9 = 6500;
  _id_76AB620FD7CC70BD = 3250;
  _id_67751D5D1646A2AE = 1500;
  heightoffset = (0, 0, 0);
  _id_361663D437DB22F5 = 1500;
  direction = (0, 0, 0);
  _id_505331AD630BBC6B = 1;

  if(isDefined(_id_5FA1E1697A302583))
    _id_76AB620FD7CC70BD = _id_5FA1E1697A302583.origin[2] + 750;

  localeid = scripts\cp_mp\utility\game_utility::getlocaleid();

  if(isDefined(localeid) && localeid == "locale_6")
    _id_76AB620FD7CC70BD = _id_76AB620FD7CC70BD + 500;

  _id_626B0E2269D27A1E = (0, 0, 0);
  direction = (0, 0, 0);
  _id_7160942C9F4921F7 = scripts\engine\utility::getStruct("harrier_spawnpoint", "script_noteworthy").origin;

  if(istrue(_id_F8FBA28C44387FD8))
    _id_7160942C9F4921F7 = scripts\engine\utility::getStruct("harrier_flyby_start", "script_noteworthy").origin;

  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  _id_28F8F60414DFB888 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(level.players[0], _id_7160942C9F4921F7, direction, "veh_hover_jet_cp", "veh8_mil_air_halfa_east");

  if(!isDefined(_id_28F8F60414DFB888)) {
    return;
  }
  level._id_1938257AED3C116A = 1;
  _id_28F8F60414DFB888.speed = 250;
  _id_28F8F60414DFB888.accel = 175;
  _id_28F8F60414DFB888.health = 1000;
  _id_28F8F60414DFB888.maxhealth = 1000;
  _id_28F8F60414DFB888.angles = vectortoangles(direction);
  _id_28F8F60414DFB888.team = "axis";
  _id_28F8F60414DFB888.flaresreservecount = 3;
  _id_28F8F60414DFB888.returngoal = _id_626B0E2269D27A1E;
  _id_28F8F60414DFB888.currentdamagestate = 0;
  _id_28F8F60414DFB888.flyheight = _id_76AB620FD7CC70BD;
  _id_28F8F60414DFB888.hoverheight = _id_67751D5D1646A2AE;
  _id_28F8F60414DFB888.missiles = 6;
  _id_28F8F60414DFB888.pers["team"] = _id_28F8F60414DFB888.team;
  _id_28F8F60414DFB888.bestgroundtarget = undefined;
  _id_28F8F60414DFB888.bestairtarget = undefined;
  _id_28F8F60414DFB888.vehiclename = "hover_jet";
  _id_28F8F60414DFB888.isempty = 0;
  _id_28F8F60414DFB888 setmaxpitchroll(30, 10);
  _id_28F8F60414DFB888 vehicle_setspeed(_id_28F8F60414DFB888.speed, _id_28F8F60414DFB888.accel);
  _id_28F8F60414DFB888 sethoverparams(250, 100, 100);
  _id_28F8F60414DFB888 setyawspeed(45, 25, 25, 0.5);
  _id_28F8F60414DFB888 setCanDamage(1);
  _id_28F8F60414DFB888 setneargoalnotifydist(512);
  _id_28F8F60414DFB888 setvehicleteam(_id_28F8F60414DFB888.team);
  _id_28F8F60414DFB888 setturningability(1);
  _id_C968F833EFAE7451 = spawnturret("misc_turret", _id_28F8F60414DFB888 gettagorigin("tag_left_archer_missile"), "hover_jet_turret_cp");
  _id_06942C17260171CB = spawnturret("misc_turret", _id_28F8F60414DFB888 gettagorigin("tag_right_archer_missile"), "hover_jet_turret_cp");
  _id_C968F833EFAE7451._id_01CD1D08A3C2DB18 = "tag_left_archer_missile";
  _id_06942C17260171CB._id_01CD1D08A3C2DB18 = "tag_right_archer_missile";
  turrets = [_id_C968F833EFAE7451, _id_06942C17260171CB];

  foreach(turret in turrets) {
    turret setModel("veh9_mil_air_halfa_turret");
    turret.team = _id_28F8F60414DFB888.team;
    turret.angles = _id_28F8F60414DFB888.angles;
    turret linkTo(_id_28F8F60414DFB888, turret._id_01CD1D08A3C2DB18, (0, 0, 5), (0, 0, 0));
    turret setturretteam(_id_28F8F60414DFB888.team);
    turret setturretmodechangewait(0);
    turret setmode("manual_target");
    turret setturretteam(_id_28F8F60414DFB888.team);
    turret setdefaultdroppitch(90);
    turret maketurretinoperable();
    turret setleftarc(360);
    turret setrightarc(360);
    turret setbottomarc(90);
    turret settoparc(90);
    turret setconvergencetime(0, "pitch");
    turret setconvergencetime(0.2, "yaw");
    turret setconvergenceheightpercent(0.65);
  }

  _id_28F8F60414DFB888.turrets = turrets;
  _id_28F8F60414DFB888.killcament = spawn("script_model", _id_28F8F60414DFB888.turrets[0] gettagorigin("bi_center"));
  _id_28F8F60414DFB888.killcament linkTo(_id_28F8F60414DFB888, "tag_origin", (-500, 0, 500), (0, 0, 0));
  _id_28F8F60414DFB888.damagecallback = ::_id_EE53706B30D63747;
  level._id_B3826A903E994BA3 = _id_28F8F60414DFB888;
  _id_28F8F60414DFB888 _id_8951054F6E51484A(_id_28F8F60414DFB888);
  _id_F5A2C2EC119E5A0C = 0;

  if(getdvarint("dvar_033F81333101EB3E", 0) > 0)
    _id_F5A2C2EC119E5A0C = 1;

  _id_8877C998195B27DE(_id_F5A2C2EC119E5A0C);
  _id_28F8F60414DFB888 _id_0AB7BE1934C5838C(_id_28F8F60414DFB888);
  _id_28F8F60414DFB888 _id_4298DA6E72A6EE8E(_id_28F8F60414DFB888);
  _id_28F8F60414DFB888 setCanDamage(1);
  _id_34DFC67DD9CBAC0B::_id_2EFE4AE8ADF0E384(_id_28F8F60414DFB888, "tag_origin", ::_id_0A28E52E4B0EF47A, 256, (0, 0, 60));
  _id_28F8F60414DFB888 thread _id_EA8750CC26465D1B(_id_28F8F60414DFB888);
  _id_28F8F60414DFB888 thread _id_374A3340C137894B(_id_28F8F60414DFB888, _id_F8FBA28C44387FD8);
  level thread _id_05428B136D0D57D7();
  _id_28F8F60414DFB888 thread _id_5D207E89249EB139();
  _id_28F8F60414DFB888 thread _id_4C3FA07EE5842A72();
  level notify("harrier_boss_spawned");
}

_id_4C3FA07EE5842A72() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("planted_beacon", _id_FF6256C1889A425D, _id_C327ADFAD89EFC23);
    _id_52F9B3F7B5F1372C = _id_B0DB7C2656C08DE8();

    if(_id_52F9B3F7B5F1372C < 2) {
      continue;
    }
    wait 0.5;
    thread scripts\cp\utility::cp_add_dialogue_line(&"CP_HARRIER_BOSS/JAMMING_START");
    level thread _id_18AF78602B67B70C::_id_775CD164C569E279("dx_guid8bb6b361e93b4234b866061c7c7ad2a6");
    message = level scripts\engine\utility::waittill_any_timeout_1(20, "sam_impact_successful");

    if(message == "timeout") {
      thread scripts\cp\utility::cp_add_dialogue_line(&"CP_HARRIER_BOSS/BEACON_JAMMED");
      level thread _id_18AF78602B67B70C::_id_775CD164C569E279("dx_guid817e048534464d5ea328923987d53878");
      level thread _id_34DFC67DD9CBAC0B::_id_DCAEE0A35F84385C(_id_C327ADFAD89EFC23);
    }

    waitframe();
  }
}

_id_5D207E89249EB139() {
  level endon("game_ended");
  self endon("death");
  _id_28F8F60414DFB888 = self;
  _id_E110DD0AACE4433F = 0;
  _id_CEEE44DE39E1B67C = 7;

  for(;;) {
    if(_id_41ED9F30C01DF20D(self)) {
      wait(_id_CEEE44DE39E1B67C);

      if(_id_41ED9F30C01DF20D(self))
        _id_421A24129BCE7737();
    }

    wait 0.5;
  }
}

_id_421A24129BCE7737() {
  level endon("game_ended");
  self endon("death");
  self _meth_3F91F38D734BB736(self.origin + (120, 0, 0), 5);

  foreach(player in level.players) {
    if(player istouching(self))
      _id_47D14CE1F66D484E(player, self);
  }

  wait 3;
}

_id_47D14CE1F66D484E(player, _id_8DDFA6266DADF2F8) {
  dir = -1 * anglesToForward(player.angles);
  _id_D01387BDA9E91E50 = player getvelocity();
  _id_ADC4B2BF275805C7 = clamp(length2d(_id_D01387BDA9E91E50), 2000, 9999);
  player knockback(dir, _id_ADC4B2BF275805C7);
}

_id_41ED9F30C01DF20D(_id_28F8F60414DFB888) {
  foreach(player in level.players) {
    if(player istouching(_id_28F8F60414DFB888))
      return 1;
  }

  return 0;
}

_id_8951054F6E51484A(_id_28F8F60414DFB888) {
  pilot = spawn("script_model", _id_28F8F60414DFB888.origin);
  pilot.angles = scripts\engine\utility::ter_op(isDefined(_id_28F8F60414DFB888.angles), _id_28F8F60414DFB888.angles, (0, 0, 0));
  pilot setModel("body_mp_helicopter_crew");
  waitframe();
  _id_C482EABCA7600ABB = spawn("script_model", pilot.origin);
  _id_C482EABCA7600ABB setModel("head_pilot_helicopter_british");
  waitframe();
  pilot.origin = _id_28F8F60414DFB888 gettagorigin("tag_pilot");
  pilot.angles = _id_28F8F60414DFB888 gettagangles("tag_pilot");
  _id_C482EABCA7600ABB.origin = pilot gettagorigin("j_neck");
  pilot linkTo(_id_28F8F60414DFB888, "tag_pilot", (0, 0, -30), (0, 0, 0));
  _id_C482EABCA7600ABB linkTo(pilot, "j_neck", (-8, 1, 0), (0, 0, 0));
  pilot scriptmodelplayanim("cnv_chase_techo_driver_fire_drive_enmy01");
  _id_28F8F60414DFB888.pilot = pilot;
  pilot.head = _id_C482EABCA7600ABB;
  pilot thread _id_52113CFE31B13029(_id_28F8F60414DFB888);
  _id_D8F65165B0443BAD = spawn("script_model", pilot.origin + (-15, 0, 25));
  _id_D8F65165B0443BAD setModel("military_nuke_core_ball");
  _id_D8F65165B0443BAD linkTo(_id_28F8F60414DFB888);
  _id_28F8F60414DFB888._id_D8F65165B0443BAD = _id_D8F65165B0443BAD;
  _id_D8F65165B0443BAD thread _id_CE65DA99C47B5A4E(_id_28F8F60414DFB888);
}

_id_5F7DDD2D9986E07F(pilot) {
  level endon("game_ended");
  wait 4;
  pilot notify("damage", 100, level.players[0]);
}

_id_CE65DA99C47B5A4E(_id_28F8F60414DFB888) {
  level endon("game_ended");
  _id_28F8F60414DFB888 endon("death");
  self setCanDamage(1);

  foreach(player in level.players)
  self hidefromplayer(player);

  _id_28F8F60414DFB888 waittill("ready_for_pilot_execution");
  waitframe();

  for(;;) {
    self waittill("damage", _id_8BBC2903A2793B49, attacker, dir, point, type, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);

    if(!isPlayer(attacker)) {
      waitframe();
      continue;
    }

    iprintlnbold("damage pilot");

    if(istrue(_id_28F8F60414DFB888._id_361B47825EA3B053)) {
      if(isDefined(_id_28F8F60414DFB888.pilot.head))
        _id_28F8F60414DFB888.pilot.head delete();

      if(isDefined(_id_28F8F60414DFB888.pilot))
        _id_28F8F60414DFB888.pilot delete();

      _id_28F8F60414DFB888 notify("entered_death_sequence");
      _id_28F8F60414DFB888 thread _id_39ED3E75FE7DBD15(_id_28F8F60414DFB888, attacker);
      return;
    }

    waitframe();
  }
}

_id_52113CFE31B13029(_id_28F8F60414DFB888) {
  level endon("game_ended");
  _id_28F8F60414DFB888 endon("death");
  self endon("death");
  pilot = _id_28F8F60414DFB888.pilot;

  for(;;) {
    if(!istrue(_id_28F8F60414DFB888._id_361B47825EA3B053)) {
      wait 2;
      continue;
    }

    player = _id_D78D39129A614E6E(pilot, 300);
    pilot scriptmodelplayanim("cnv_chase_techo_driver_fire_shoot_enmy01");
    wait 1;
    pilot scriptmodelplayanim("cnv_chase_techo_driver_fire_outro_enmy01");
    wait 1;
    pilot scriptmodelplayanim("cnv_chase_techo_driver_fire_drive_enmy01");
    _id_661B6B8DF54D6C9F(pilot, player, 300);
  }
}

_id_661B6B8DF54D6C9F(ent, player, radius) {
  level endon("game_ended");
  player endon("death");
  player endon("disconnect");

  while(distance(player.origin, ent.origin) >= radius)
    wait 1;
}

_id_D78D39129A614E6E(ent, radius) {
  level endon("game_ended");

  for(;;) {
    foreach(player in level.players) {
      if(distance(player.origin, ent.origin) <= radius)
        return player;
    }

    wait 0.5;
  }
}

_id_8877C998195B27DE(_id_41D8BF229CF29051) {
  level._id_B3826A903E994BA3._id_361B47825EA3B053 = _id_41D8BF229CF29051;

  if(istrue(_id_41D8BF229CF29051)) {
    level._id_B3826A903E994BA3 hidepart("tag_canopy");
    level._id_B3826A903E994BA3 notify("ready_for_pilot_execution");

    if(isDefined(level._id_E1CFA96FB6789FCB))
      _id_7E1F3A5AA9B072AF::_id_BA9AF0BC3B5CF4D7(level._id_E1CFA96FB6789FCB);
  }
}

_id_EA8750CC26465D1B(_id_61DD90FF44CE35DA) {
  if(!isDefined(level.special_lockon_target_list))
    level.special_lockon_target_list = [];

  level.special_lockon_target_list[level.special_lockon_target_list.size] = _id_61DD90FF44CE35DA;
}

_id_989626DD135EF898(blocknumber, _id_41D8BF229CF29051) {
  _id_329B5C62B9D71EC8 = "gauntlet_block_" + blocknumber;

  foreach(_id_938F333E5DC17DC6 in level._id_73AFADCEE4337651) {
    if(_id_938F333E5DC17DC6.targetname == _id_329B5C62B9D71EC8) {
      if(istrue(_id_41D8BF229CF29051)) {
        _id_938F333E5DC17DC6 solid();
        _id_938F333E5DC17DC6 show();
      } else {
        _id_938F333E5DC17DC6 hide();
        _id_938F333E5DC17DC6 notsolid();
      }

      return;
    }
  }
}

_id_4298DA6E72A6EE8E(_id_28F8F60414DFB888) {
  _id_1BA0E552ED27BB6E = scripts\engine\utility::getStruct("harrier_flyby_takeoff", "script_noteworthy");
  startstruct = scripts\engine\utility::getStruct("harrier_flyby_start", "script_noteworthy");
  _id_D0697AF2ECA83D63 = scripts\engine\utility::getStruct("harrier_flyby_end", "script_noteworthy");
  _id_1BA0E552ED27BB6E._id_9BC5CB3240D03C4C = spawn("script_model", _id_1BA0E552ED27BB6E.origin);
  _id_1BA0E552ED27BB6E._id_9BC5CB3240D03C4C setModel("tag_origin");
  startstruct._id_9BC5CB3240D03C4C = spawn("script_model", startstruct.origin);
  startstruct._id_9BC5CB3240D03C4C setModel("tag_origin");
  _id_D0697AF2ECA83D63._id_9BC5CB3240D03C4C = spawn("script_model", _id_D0697AF2ECA83D63.origin);
  _id_D0697AF2ECA83D63._id_9BC5CB3240D03C4C setModel("tag_origin");
  _id_0BEEFAAA964DD21E = scripts\engine\utility::getStruct("harrier_flyby_focus", "script_noteworthy");
  _id_6B70F24512689931 = spawn("script_model", _id_0BEEFAAA964DD21E.origin);
  _id_6B70F24512689931 setModel("tag_origin");
  _id_28F8F60414DFB888._id_6B70F24512689931 = _id_6B70F24512689931;
}

_id_B48C311FA7628B0E() {
  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
    _id_C9E75DC99FEF9F93 = getEntArray("hover_dangerarea_" + _id_AC0E594AC96AA3A8, "script_noteworthy");

    foreach(ent in _id_C9E75DC99FEF9F93) {
      ent hide();
      ent notsolid();
      ent connectpaths();
    }
  }

  _id_0A7713DED0EF2B43 = scripts\engine\utility::getStructArray("hover_1_laser_edge", "script_noteworthy");
  _id_4BEC6A14D08B74FE = scripts\engine\utility::getStructArray("hover_2_laser_edge", "script_noteworthy");
  _id_42B2A70DC6B08F99 = scripts\engine\utility::getStructArray("hover_3_laser_edge", "script_noteworthy");
  _id_5ABE9797BA469883 = scripts\cp\utility::array_merge(_id_0A7713DED0EF2B43, _id_4BEC6A14D08B74FE);
  _id_5ABE9797BA469883 = scripts\cp\utility::array_merge(_id_5ABE9797BA469883, _id_42B2A70DC6B08F99);
  level._id_6A1054E0923DF439 = [];

  foreach(_id_0C3EA9B1A20FF199 in _id_5ABE9797BA469883) {
    _id_717A4F79FF9E995D = spawn("script_model", _id_0C3EA9B1A20FF199.origin);
    _id_717A4F79FF9E995D setModel("tag_origin");
    _id_717A4F79FF9E995D.index = _id_0C3EA9B1A20FF199.script_noteworthy[6];
    level._id_6A1054E0923DF439[level._id_6A1054E0923DF439.size] = _id_717A4F79FF9E995D;
  }
}

_id_7A49AEE6918670C4() {
  if(!isDefined(level._id_B3826A903E994BA3)) {
    return;
  }
  _id_61DD90FF44CE35DA = level._id_B3826A903E994BA3;

  if(!isDefined(_id_61DD90FF44CE35DA._id_5A5366AE0037B264)) {
    return;
  }
  foreach(vfx in _id_61DD90FF44CE35DA._id_5A5366AE0037B264)
  vfx delete();

  _id_61DD90FF44CE35DA._id_5A5366AE0037B264 = [];
}

_id_20F8119825DD9478(_id_B4DB2904F3EA3821) {
  _id_0FCB2A8F8BB1AAA4 = _id_B4DB2904F3EA3821.script_noteworthy[_id_B4DB2904F3EA3821.script_noteworthy.size - 1];

  if(!isDefined(level._id_B3826A903E994BA3)) {
    return;
  }
  _id_61DD90FF44CE35DA = level._id_B3826A903E994BA3;

  if(!isDefined(_id_61DD90FF44CE35DA._id_5A5366AE0037B264))
    _id_61DD90FF44CE35DA._id_5A5366AE0037B264 = [];

  foreach(_id_0C3EA9B1A20FF199 in level._id_6A1054E0923DF439) {
    if(_id_0C3EA9B1A20FF199.index == _id_0FCB2A8F8BB1AAA4)
      _id_61DD90FF44CE35DA._id_5A5366AE0037B264[_id_61DD90FF44CE35DA._id_5A5366AE0037B264.size] = playfxontagsbetweenclients(level._effect["harrier_red_laser"], _id_61DD90FF44CE35DA, "tag_barrel_view", _id_0C3EA9B1A20FF199, "tag_origin");
  }
}

_id_0AB7BE1934C5838C(_id_28F8F60414DFB888) {
  _id_28F8F60414DFB888._id_A83387E46C19DC56 = [];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
    index = _id_28F8F60414DFB888._id_A83387E46C19DC56.size;
    _id_28F8F60414DFB888._id_A83387E46C19DC56[index] = scripts\engine\utility::getStruct("harrier_hoverspot_" + _id_AC0E594AC96AA3A8, "script_noteworthy");
    _id_28F8F60414DFB888._id_A83387E46C19DC56[index].index = _id_AC0E594AC96AA3A8;
    _id_28F8F60414DFB888._id_A83387E46C19DC56[index]._id_4E10555236D57214 = getEnt("hoverattack_area" + _id_AC0E594AC96AA3A8, "script_noteworthy");
    _id_03B819B9C304F403 = scripts\engine\utility::getStruct(_id_28F8F60414DFB888._id_A83387E46C19DC56[index].target, "targetname");
    _id_28F8F60414DFB888._id_A83387E46C19DC56[index]._id_A08A3023D4588168 = spawn("script_model", _id_03B819B9C304F403.origin);
    _id_28F8F60414DFB888._id_A83387E46C19DC56[index]._id_A08A3023D4588168 setModel("tag_origin");
    _id_DD7C32625FEBF52E = scripts\engine\utility::getStruct("hoverattack_faceto_" + _id_AC0E594AC96AA3A8, "script_noteworthy");
    _id_28F8F60414DFB888._id_A83387E46C19DC56[index]._id_DD7C32625FEBF52E = spawn("script_model", _id_DD7C32625FEBF52E.origin);
    _id_28F8F60414DFB888._id_A83387E46C19DC56[index]._id_DD7C32625FEBF52E setModel("tag_origin");
  }
}

_id_15C391925185D1AB(player, _id_0C3EA9B1A20FF199) {
  return istrue(player istouching(_id_0C3EA9B1A20FF199._id_4E10555236D57214));
}

_id_8AA148C1E2E416CF(player) {
  if(_id_A387A3A903F7DF2D("basement_trigger", player) || _id_A387A3A903F7DF2D("bunker_trigger", player) || _id_A387A3A903F7DF2D("gauntlet_trigger", player) || !isalive(player))
    return 0;

  return 1;
}

_id_DC68EAD31D80490D(_id_28F8F60414DFB888) {
  level endon("game_ended");
  _id_28F8F60414DFB888 endon("death");

  for(;;) {
    if(!isDefined(level._id_B3826A903E994BA3._id_A83387E46C19DC56))
      wait 2;

    _id_7F65B6A8C27835FD = 15;

    foreach(_id_0C3EA9B1A20FF199 in level._id_B3826A903E994BA3._id_A83387E46C19DC56)
    level thread scripts\engine\utility::draw_circle(_id_0C3EA9B1A20FF199._id_A08A3023D4588168.origin, 128, (0, 0, 1), 1, 0, _id_7F65B6A8C27835FD * 60);

    wait(_id_7F65B6A8C27835FD);
  }
}

_id_37B1257733BFF5B9() {
  if(!isDefined(level._id_B3826A903E994BA3) || !isDefined(level._id_B3826A903E994BA3._id_983C6A727F5D4DEF))
    return "";

  return level._id_B3826A903E994BA3._id_983C6A727F5D4DEF;
}

_id_3011B5241EEEFC8F() {
  level endon("game_ended");
  self endon("death");
  self endon("entered_daze_phase");
  self endon("entered_death_sequence");
  self endon("entered_clearingroof_phase");
  _id_CED0426E7E729ED5 = scripts\engine\utility::getStruct("debug_attack_target", "script_noteworthy");
  targetent = _id_CED0426E7E729ED5 scripts\engine\utility::spawn_tag_origin();
  self._id_983C6A727F5D4DEF = "debugattack";
  _id_AEFB29133330F0CB = makeweapon("hover_jet_turret_cp");
  _id_2C90EA28723E0BF7 = weaponfiretime(_id_AEFB29133330F0CB);

  foreach(turret in self.turrets)
  turret settargetentity(targetent, (0, 10, 0));

  start_time = gettime();

  while(_id_37B1257733BFF5B9() == "debugattack") {
    foreach(turret in self.turrets)
    turret shootturret();

    wait(_id_2C90EA28723E0BF7);
  }

  _id_AEFB29133330F0CB delete();
}

_id_76BAE8816C808015(player) {
  level endon("game_ended");
  player notifyonplayercommand("put_on_plane", "+frag");

  for(;;) {
    player waittill("put_on_plane");

    if(!isalive(player) || !isDefined(level._id_B3826A903E994BA3)) {
      continue;
    }
    _id_28F8F60414DFB888 = level._id_B3826A903E994BA3;
    destination = scripts\cp\utility::get_point_in_local_ent_space(_id_28F8F60414DFB888, (0, 0, 100));
    player setOrigin(destination, 1, 1);
  }
}

_id_187AFEFAEE6F837E() {
  level endon("game_ended");
  self endon("death");
  self endon("entered_death_sequence");
  self._id_983C6A727F5D4DEF = "moving";
  _id_359C369878700167 = [];
  _id_C26C184F85BA2B4B = scripts\engine\utility::getStruct("harrier_stdattack_start", "script_noteworthy");
  _id_325ED201CF556899 = _id_C26C184F85BA2B4B;

  for(_id_359C369878700167[0] = _id_C26C184F85BA2B4B; isDefined(_id_325ED201CF556899.target); _id_325ED201CF556899 = _id_643663ADE1FACC85) {
    _id_643663ADE1FACC85 = scripts\engine\utility::getStruct(_id_325ED201CF556899.target, "targetname");
    _id_359C369878700167[_id_359C369878700167.size] = _id_643663ADE1FACC85;
  }

  lastindex = 0;

  foreach(player in level.players)
  level thread _id_76BAE8816C808015(player);

  for(;;) {
    speed = getdvarfloat("dvar_F5F0246D8315ACCE", 10);
    _id_D99757891D1ED279 = getdvarfloat("dvar_E2539D55E1B8B98F", 10);
    _id_25B8738CCC2F5E33 = getdvarint("dvar_6E50D4C9AFA422ED", 1);
    _id_0993E5CFF91E2CEE = getdvarint("dvar_78D4E097BB386580", 1);
    _id_D99757891D1ED279 = getdvarfloat("dvar_3B4DC68F9D5D2C51", 25);
    _id_390142E4D624D3F4 = getdvarfloat("dvar_EED2C382F9C7A01E", 15);
    _id_EBECCB8E554EACAF = getdvarfloat("dvar_4F099AF236B4419D", 10);
    _id_B0644D6698EA73E7 = getdvarfloat("dvar_D0985F643C6F4F75", 512);
    self setneargoalnotifydist(_id_B0644D6698EA73E7);
    self vehicle_setspeed(speed, _id_D99757891D1ED279, _id_D99757891D1ED279);
    self setvehgoalpos(_id_359C369878700167[lastindex].origin, _id_25B8738CCC2F5E33);

    if(istrue(_id_0993E5CFF91E2CEE))
      self setlookatent(level.players[0]);

    self sethoverparams(_id_D99757891D1ED279, _id_390142E4D624D3F4, _id_EBECCB8E554EACAF);
    scripts\engine\utility::waittill_any_timeout_3(20, "near_goal", "goal", "goal_reached");
    lastindex++;

    if(lastindex >= _id_359C369878700167.size)
      lastindex = 0;
  }
}

_id_58BF43570F33683D(_id_28F8F60414DFB888) {
  level endon("game_ended");
  _id_28F8F60414DFB888 endon("death");
  _id_28F8F60414DFB888 endon("entered_daze_phase");
  _id_28F8F60414DFB888 endon("entered_aggro_phase");
  _id_28F8F60414DFB888 endon("entered_death_sequence");
  _id_28F8F60414DFB888 endon("entered_clearingroof_phase");
  _id_28F8F60414DFB888 endon("starting_revenge_sequence");

  if(!_id_BEA60A0EA24D485A()) {
    return;
  }
  _id_28F8F60414DFB888._id_983C6A727F5D4DEF = "standardattack";
  _id_28F8F60414DFB888._id_08B04DA884ED634A = "standardattack";
  _id_28F8F60414DFB888 notify("turn_off_laser_vfx");
  _id_C26C184F85BA2B4B = scripts\engine\utility::getStruct("harrier_stdattack_start", "script_noteworthy");
  _id_137CC0FFDF383E20 = _id_8EC9049CD6BB8968();

  if(getdvarint("dvar_6247E9406B12D7B3", 0) > 0)
    _id_28F8F60414DFB888 thread _id_6155181263E53912(_id_28F8F60414DFB888, _id_137CC0FFDF383E20, "harrier_green_laser");

  _id_28F8F60414DFB888 thread _id_4D9EE6400B8CF346();

  if(!isDefined(_id_137CC0FFDF383E20)) {
    wait 1;
    return;
  }

  _id_28F8F60414DFB888 setmaxpitchroll(30, 10);
  _id_28F8F60414DFB888 vehicle_setspeed(200, 50, 50);
  _id_28F8F60414DFB888 setneargoalnotifydist(512);
  _id_28F8F60414DFB888 setlookatent(_id_137CC0FFDF383E20);
  _id_28F8F60414DFB888 sethoverparams(250, 100, 100);
  _id_28F8F60414DFB888 setvehgoalpos(_id_C26C184F85BA2B4B.origin, 1);
  _id_28F8F60414DFB888 scripts\engine\utility::waittill_any_timeout_3(10, "near_goal", "goal", "goal_reached");
  _id_28F8F60414DFB888 vehicle_setspeed(10, 50, 50);
  _id_E6CB3508CB26F9E1 = _id_C26C184F85BA2B4B;
  _id_57F5444230951BC7 = scripts\engine\utility::getStruct(_id_E6CB3508CB26F9E1.target, "targetname");
  _id_28F8F60414DFB888 thread _id_F41D3ED5777FC07D(_id_137CC0FFDF383E20, "standardattack", 3, 8);

  for(;;) {
    wait 1;

    if(!isDefined(_id_E6CB3508CB26F9E1.target)) {
      _id_28F8F60414DFB888 notify("turn_off_laser_vfx");
      return;
    }

    _id_57F5444230951BC7 = scripts\engine\utility::getStruct(_id_E6CB3508CB26F9E1.target, "targetname");
    _id_28F8F60414DFB888 setvehgoalpos(_id_57F5444230951BC7.origin, 1);
    _id_28F8F60414DFB888 scripts\engine\utility::waittill_any_timeout_3(10, "near_goal", "goal", "goal_reached");
    _id_E6CB3508CB26F9E1 = _id_57F5444230951BC7;
  }

  _id_28F8F60414DFB888 notify("finished_standard_attack");
  _id_28F8F60414DFB888 clearlookatent();
  _id_28F8F60414DFB888 notify("turn_off_laser_vfx");
}

_id_52490A91C2E90A4D(_id_28F8F60414DFB888, _id_F8FBA28C44387FD8) {
  level endon("game_ended");
  _id_28F8F60414DFB888._id_983C6A727F5D4DEF = "intro";

  if(!istrue(_id_F8FBA28C44387FD8)) {
    _id_C26C184F85BA2B4B = scripts\engine\utility::getStruct("harrier_intro_top", "script_noteworthy");
    _id_28F8F60414DFB888 vehicle_setspeed(200, 50, 50);
    _id_28F8F60414DFB888 setneargoalnotifydist(512);
    _id_28F8F60414DFB888 sethoverparams(250, 100, 100);
    _id_28F8F60414DFB888 setvehgoalpos(_id_C26C184F85BA2B4B.origin, 1);
    _id_28F8F60414DFB888 scripts\engine\utility::waittill_any_timeout_2(5, "goal", "goal_reached");
    _id_21B28C28446D35F4 = scripts\engine\utility::getStruct("harrier_intro_end", "script_noteworthy");
    _id_28F8F60414DFB888 setvehgoalpos(_id_21B28C28446D35F4.origin, 1);
    _id_28F8F60414DFB888 scripts\engine\utility::waittill_any_timeout_2(5, "goal", "goal_reached");
  }

  level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_HARRIER_BOSS/HARRIER_SPAWNED");
  level thread _id_18AF78602B67B70C::_id_775CD164C569E279("dx_guidb1fc2709603e4fe2aa3a33d647ca9e15");
  _id_28F8F60414DFB888 _id_A8118ABFFAF40D1F(_id_F8FBA28C44387FD8);
  _id_28F8F60414DFB888._id_983C6A727F5D4DEF = "moving";
}

_id_374A3340C137894B(_id_28F8F60414DFB888, _id_F8FBA28C44387FD8) {
  level endon("game_ended");
  _id_28F8F60414DFB888 endon("death");
  _id_28F8F60414DFB888 endon("entered_death_sequence");
  _id_28F8F60414DFB888._id_983C6A727F5D4DEF = "idle";
  level thread _id_FED4FB4FCE9698BC(_id_28F8F60414DFB888);

  if(getdvarint("dvar_A0ADA695FC1AB1F6", 0) <= 0)
    level thread _id_D7D5808D00C94126();

  _id_28F8F60414DFB888 _id_52490A91C2E90A4D(_id_28F8F60414DFB888, _id_F8FBA28C44387FD8);

  for(;;) {
    if(getdvarint("dvar_7F4B5C5CBF6FC4CC", 0) > 0) {
      _id_28F8F60414DFB888 _id_187AFEFAEE6F837E();
      waitframe();
      continue;
    }

    if(getdvarint("dvar_BA659199024AF847", 0) > 0) {
      _id_28F8F60414DFB888 _id_0A28E52E4B0EF47A();
      waitframe();
      continue;
    }

    _id_28F8F60414DFB888 _id_EE128D7AD8B0151D();
    _id_28F8F60414DFB888 _id_97EF1E3F6FF66BBB();
  }
}

_id_FED4FB4FCE9698BC(_id_28F8F60414DFB888) {
  level endon("game_ended");
  _id_28F8F60414DFB888 endon("death");
  _id_56AEB6D74D9FBB4D = getEnt("gauntlet_roof_trigger", "script_noteworthy");
  _id_56AEB6D74D9FBB4D._id_BE8B197C09AD77D3 = 0;

  if(!isDefined(_id_28F8F60414DFB888._id_23C44A0944252197))
    _id_28F8F60414DFB888._id_23C44A0944252197 = 0;

  for(;;) {
    _id_56AEB6D74D9FBB4D waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    _id_56AEB6D74D9FBB4D._id_BE8B197C09AD77D3 = gettime();

    while(!_id_106E32A37C0137D4(_id_56AEB6D74D9FBB4D) && gettime() - _id_28F8F60414DFB888._id_23C44A0944252197 < 30000 && gettime() - _id_56AEB6D74D9FBB4D._id_BE8B197C09AD77D3 < 20000)
      wait 0.5;

    if(!_id_106E32A37C0137D4(_id_56AEB6D74D9FBB4D) && _id_BEA60A0EA24D485A() && !istrue(level._id_A041C83B7BD74D22)) {
      if(_id_A387A3A903F7DF2D("gauntlet_roof_trigger", player))
        _id_28F8F60414DFB888 thread _id_33B0304B931850DC(_id_28F8F60414DFB888, player);
      else {
        foreach(_id_6EE5484560EC747C in level.players) {
          if(_id_6EE5484560EC747C istouching(_id_56AEB6D74D9FBB4D))
            _id_28F8F60414DFB888 thread _id_33B0304B931850DC(_id_28F8F60414DFB888, _id_6EE5484560EC747C);
        }
      }

      wait 30;
      _id_56AEB6D74D9FBB4D._id_BE8B197C09AD77D3 = gettime();
    }
  }
}

_id_D7D5808D00C94126() {
  level endon("game_ended");
  level endon("vtol_destroyed");
  trigger = getEnt("samsite_trigger", "script_noteworthy");
  trigger._id_BE8B197C09AD77D3 = 0;

  if(!isDefined(trigger)) {
    return;
  }
  for(;;) {
    trigger waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    trigger._id_BE8B197C09AD77D3 = gettime();

    while(!_id_106E32A37C0137D4(trigger) && gettime() - trigger._id_BE8B197C09AD77D3 < 20000)
      wait 0.5;

    if(!_id_106E32A37C0137D4(trigger) && !istrue(level._id_A041C83B7BD74D22)) {
      if(_id_A387A3A903F7DF2D("samsite_trigger", player)) {
        if(randomint(100) > 50) {
          _id_72DAC79A97FC7C5C = scripts\engine\utility::getStruct("heli_infils_4", "script_noteworthy");

          if(!isDefined(_id_72DAC79A97FC7C5C)) {
            return;
          }
          spawners = scripts\engine\utility::getStructArray("heli_squad_4", "targetname");
          scripts\cp\cp_spawning_util::_id_94E3A9862B435632(_id_72DAC79A97FC7C5C, spawners);
        } else
          level thread _id_18A73A64992DD07D::run_spawn_module("samsite_grenadiers");
      }

      wait 30;
      trigger._id_BE8B197C09AD77D3 = gettime();
    }
  }
}

_id_CE6764A5678CC442() {
  self endon("death");
  level endon("game_ended");
  _id_642C8236AC0350DF = scripts\engine\utility::getStructArray("sam_grenadier_spot", "script_noteworthy");
  _id_D646B30F0EA6A0F0 = scripts\engine\utility::getStruct("sam_grenade_dest", "script_noteworthy").origin;
  destination = scripts\engine\utility::random(_id_642C8236AC0350DF);
  self.goalradius = 8;
  self.script_radius = 8;
  self setgoalpos(self getclosestreachablepointonnavmesh(destination.origin));
  _id_22A07A15C5CB2516(destination.origin, squared(384));
  self.ignoreall = 1;
  self.allowpain = 0;
  _id_4EB81068E9E3B394 = getEnt("samsite_trigger", "script_noteworthy");

  if(!isDefined(_id_4EB81068E9E3B394)) {
    return;
  }
  while(!_id_106E32A37C0137D4(_id_4EB81068E9E3B394)) {
    _id_B7BC618531B4D6E3 = _id_D646B30F0EA6A0F0;

    foreach(player in level.players) {
      if(_id_A387A3A903F7DF2D("samsite_trigger", player))
        _id_B7BC618531B4D6E3 = player.origin;
    }

    scripts\cp\utility::_id_AE99616202575E39(_id_B7BC618531B4D6E3, "semtex_mp");
    wait 5;
  }

  if(!istrue(self.dont_enter_combat))
    self.ignoreall = 0;

  self.scripted_mode = 0;
  self.playing_skit = undefined;
}

_id_22A07A15C5CB2516(origin, radius) {
  while(distancesquared(self.origin, origin) > radius)
    wait 0.1;
}

_id_C9DBF98EBCDE51D5(_id_28F8F60414DFB888) {
  level endon("game_ended");
  _id_28F8F60414DFB888 endon("death");
  _id_28F8F60414DFB888 endon("entered_daze_phase");
  _id_28F8F60414DFB888 endon("entered_aggro_phase");
  _id_28F8F60414DFB888 endon("entered_death_sequence");
  _id_28F8F60414DFB888 endon("entered_clearingroof_phase");
  _id_56AEB6D74D9FBB4D = getEnt("gauntlet_roof_trigger", "script_noteworthy");
  endtime = gettime() + 30000;
  _id_122A7C98380266C0 = 0;

  while(gettime() <= endtime && !_id_106E32A37C0137D4(_id_56AEB6D74D9FBB4D))
    wait 0.5;

  _id_28F8F60414DFB888 notify("turn_off_laser_vfx");
  _id_28F8F60414DFB888._id_983C6A727F5D4DEF = "idle";
}

_id_33B0304B931850DC(_id_28F8F60414DFB888, player) {
  level endon("game_ended");
  _id_28F8F60414DFB888 endon("entered_daze_phase");
  _id_28F8F60414DFB888 endon("entered_aggro_phase");
  _id_28F8F60414DFB888 endon("end_standard_attack");
  _id_28F8F60414DFB888 endon("entered_death_sequence");
  _id_28F8F60414DFB888 endon("starting_revenge_sequence");
  _id_28F8F60414DFB888._id_983C6A727F5D4DEF = "clearingroof";
  _id_28F8F60414DFB888 notify("entered_clearingroof_phase");
  _id_C26C184F85BA2B4B = scripts\engine\utility::getStruct("harrier_risetoroof_start", "script_noteworthy");
  _id_3526FD29AB3A3526 = scripts\engine\utility::getStruct("harrier_risetoroof_end", "script_noteworthy");
  _id_28F8F60414DFB888 vehicle_setspeed(10, 50, 50);
  _id_28F8F60414DFB888 setneargoalnotifydist(512);
  _id_28F8F60414DFB888 sethoverparams(250, 100, 100);
  _id_28F8F60414DFB888 setlookatent(player);
  _id_28F8F60414DFB888 setvehgoalpos(_id_C26C184F85BA2B4B.origin, 1);
  _id_28F8F60414DFB888 scripts\engine\utility::waittill_any_timeout_2(5, "goal", "goal_reached");
  _id_28F8F60414DFB888 setvehgoalpos(_id_3526FD29AB3A3526.origin, 1);
  _id_28F8F60414DFB888 scripts\engine\utility::waittill_any_timeout_2(5, "goal", "goal_reached");
  _id_28F8F60414DFB888 thread _id_C9DBF98EBCDE51D5(_id_28F8F60414DFB888);
  _id_28F8F60414DFB888 thread _id_F41D3ED5777FC07D(player, "clearingroof", 2, 3);
  timeout = 10;
  starttime = gettime();

  while(gettime() - starttime < timeout * 1000)
    waitframe();

  _id_28F8F60414DFB888 notify("turn_off_laser_vfx");
  _id_28F8F60414DFB888._id_983C6A727F5D4DEF = "idle";
  _id_28F8F60414DFB888 clearlookatent();
}

_id_EE128D7AD8B0151D() {
  self endon("entered_death_sequence");

  if(istrue(self._id_979B7E2496150E35)) {
    _id_A8118ABFFAF40D1F();
    self._id_979B7E2496150E35 = undefined;
  } else if(isDefined(self._id_08B04DA884ED634A) && self._id_08B04DA884ED634A == "hoverattack")
    _id_58BF43570F33683D(self);
  else
    _id_5F3189B8E8272C3E();
}

_id_FDB1806E7D3B0A5D() {
  level endon("game_ended");
  lights = scripts\engine\utility::getStructArray("bunker_light_fx", "targetname");

  foreach(light in lights)
  playFX(level._effect["vfx_ammo_beacon"], light.origin);

  while(istrue(level._id_A041C83B7BD74D22))
    wait 3;
}

_id_A8118ABFFAF40D1F(_id_C5B17C9D8FFAE024) {
  self endon("death");
  level endon("game_ended");
  self notify("starting_revenge_sequence");
  level._id_A041C83B7BD74D22 = 1;
  level thread _id_FDB1806E7D3B0A5D();

  if(istrue(_id_C5B17C9D8FFAE024))
    thread _id_BFF5C2828D6ECED0(1);
  else
    _id_B42A18BFC3E4D10A(self);

  wait 1;
  _id_AA2BABC5C4C55D94(_id_C5B17C9D8FFAE024);
  _id_52F9B3F7B5F1372C = _id_B0DB7C2656C08DE8();

  if(getdvarint("dvar_CD385F4320763B25", 0) > 0 && _id_52F9B3F7B5F1372C > 1) {
    thread _id_913C11AE59CF317F();
    level scripts\engine\utility::waittill_any_timeout_1(30, "jugg_charge_finished");
  } else
    level scripts\engine\utility::waittill_any_timeout_1(15, "jugg_charge_finished");

  _id_F92431F823F09E69();
  level._id_A041C83B7BD74D22 = 0;
}

_id_B42A18BFC3E4D10A(_id_28F8F60414DFB888) {
  _id_28F8F60414DFB888 endon("death");
  level endon("game_ended");
  _id_28F8F60414DFB888._id_983C6A727F5D4DEF = "destroying_gauntlet";
  _id_52F9B3F7B5F1372C = _id_B0DB7C2656C08DE8();

  if(_id_52F9B3F7B5F1372C == 1 || _id_52F9B3F7B5F1372C == 2) {
    _id_338C07EBDC70FB21 = scripts\engine\utility::getStruct("harrier_stdattack_start", "script_noteworthy");
    targets = scripts\engine\utility::getStructArray("gauntlet_dest_vfx_" + _id_52F9B3F7B5F1372C, "script_noteworthy");
    _id_550D831112CC5BD8 = scripts\engine\utility::getStruct("harrier_spawnpoint", "script_noteworthy");
    _id_7FC29526DE531C77 = _id_550D831112CC5BD8 scripts\engine\utility::spawn_tag_origin();
    self vehicle_setspeed(10, 50, 50);
    self setvehgoalpos(_id_338C07EBDC70FB21.origin, 1);
    self setlookatent(_id_7FC29526DE531C77);
    scripts\engine\utility::waittill_any_timeout_2(6, "goal", "goal_reached");
    wait 0.5;
    _id_902492553F7C3DAF = makeweapon("hover_jet_proj_mp");
    _id_3F5937AB90734769 = _id_28F8F60414DFB888 gettagorigin("tag_left_alamo_missile") + anglesToForward(_id_28F8F60414DFB888.angles) * 100;

    foreach(target in targets) {
      missile = scripts\cp_mp\utility\weapon_utility::_magicbullet(_id_902492553F7C3DAF, _id_3F5937AB90734769, target.origin);
      wait 0.5;
    }

    thread _id_BFF5C2828D6ECED0(_id_52F9B3F7B5F1372C);
    thread _id_BD37B076AECDB0ED([_id_7FC29526DE531C77], 3);
  }
}

_id_BD37B076AECDB0ED(_id_D61E3BE253524984, waittime) {
  level endon("game_ended");
  wait(waittime);

  foreach(ent in _id_D61E3BE253524984)
  ent delete();
}

_id_D9955353B696E95A(_id_92C4DE821390F609) {
  _id_9F47A62C5355EDDF = getEntArray(_id_92C4DE821390F609, "script_noteworthy");

  foreach(_id_36C12D04A03471D6 in _id_9F47A62C5355EDDF) {
    _id_36C12D04A03471D6 show();
    _id_36C12D04A03471D6 solid();
  }
}

_id_A3957180D1257DE9(_id_92C4DE821390F609, _id_8513841FC1F3E10D) {
  _id_9F47A62C5355EDDF = getEntArray(_id_92C4DE821390F609, "script_noteworthy");

  foreach(_id_36C12D04A03471D6 in _id_9F47A62C5355EDDF) {
    _id_36C12D04A03471D6 hide();
    _id_36C12D04A03471D6 notsolid();
  }

  if(!isDefined(_id_8513841FC1F3E10D) || !isarray(_id_8513841FC1F3E10D)) {
    return;
  }
  foreach(ref in _id_8513841FC1F3E10D)
  level thread _id_78784F1890AC2B1F(ref);
}

_id_78784F1890AC2B1F(ref) {
  level endon("game_ended");
  ref.angles = scripts\engine\utility::ter_op(isDefined(ref.angles), ref.angles, (0, 0, 0));
  _id_EFDFC6EBE7A152C5 = spawnfx(level._effect["vfx_javelin_expl"], ref.origin, anglesToForward(ref.angles) * -1.0, (0, 0, 1));
  triggerfx(_id_EFDFC6EBE7A152C5);

  if(soundexists("breach_c4_expl_trans"))
    playsoundatpos(ref.origin, "breach_c4_expl_trans");

  wait 5;
  _id_EFDFC6EBE7A152C5 delete();
}

_id_913C11AE59CF317F() {
  level endon("game_ended");
  _id_3029CF0A5974B6E2 = scripts\engine\utility::array_randomize(["bomber_jugg_left", "bomber_jugg_right"]);
  _id_51A63FB1BA558B59 = scripts\engine\utility::ter_op(_id_B0DB7C2656C08DE8() < 3, 1, 2);

  if(!isDefined(level._id_1DC7D5C54BA2D06E))
    level._id_1DC7D5C54BA2D06E = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_51A63FB1BA558B59; _id_AC0E594AC96AA3A8++) {
    level thread _id_18A73A64992DD07D::run_spawn_module(_id_3029CF0A5974B6E2[_id_AC0E594AC96AA3A8]);
    waitframe();
  }

  while(level._id_1DC7D5C54BA2D06E.size <= 0)
    waitframe();

  _id_77E10436128B9490 = 0;

  while(!istrue(_id_77E10436128B9490)) {
    if(level._id_1DC7D5C54BA2D06E.size <= 0) {
      _id_77E10436128B9490 = 1;
      continue;
    }

    _id_8054C476C1122D49 = 1;

    foreach(_id_E21279FA90BDF012 in level._id_1DC7D5C54BA2D06E) {
      if(!istrue(_id_E21279FA90BDF012._id_49066A0E2A3EAEF9))
        _id_8054C476C1122D49 = 0;
    }

    if(istrue(_id_8054C476C1122D49)) {
      _id_77E10436128B9490 = 1;
      continue;
    }

    wait 1;
  }

  wait 1;
  level._id_1DC7D5C54BA2D06E = [];
  level notify("jugg_charge_finished");
}

_id_5AD390012341F977() {
  level endon("game_ended");
  level endon("vtol_destroyed");
  level thread _id_18A73A64992DD07D::run_spawn_module("firstcontact");
  level thread _id_18A73A64992DD07D::run_spawn_module("intro_1");
  level thread _id_18A73A64992DD07D::run_spawn_module("intro_2");
  level thread _id_18A73A64992DD07D::run_spawn_module("intro_3");
  level thread _id_18A73A64992DD07D::run_spawn_module("intro_gauntlet");
  level thread _id_18A73A64992DD07D::run_spawn_module("bunker_ai");

  if(getdvarint("dvar_CD385F4320763B25", 0) > 0) {
    level thread _id_8155115E01401F00();
    level thread _id_AF8D556F5DF2BB6D();
  }

  if(getdvarint("dvar_BC6481C5BD012176", 0) <= 0)
    level thread _id_72FCFB47E6FB0E76();
}

_id_72FCFB47E6FB0E76() {
  level endon("game_ended");
  level endon("vtol_destroyed");
  level waittill("last_sam_missile_launched");
  wait 3;

  if(_id_B0DB7C2656C08DE8() == 3) {
    return;
  }
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_HARRIER_BOSS/LAST_SAM_USED");
  level thread _id_18AF78602B67B70C::_id_775CD164C569E279("dx_guid57dc296b8d9e4d4885409ef5a115a63f");
  wait 2;
  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

_id_AF8D556F5DF2BB6D() {
  level endon("game_ended");
  level waittill("ai_bomb_detonated");
  wait 1;
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BOMBER_AI/MISSION_FAIL");
  level thread _id_18AF78602B67B70C::_id_775CD164C569E279("dx_guid57dc296b8d9e4d4885409ef5a115a63f");
  wait 2;
  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

_id_8155115E01401F00() {
  level endon("game_ended");
  marker = scripts\engine\utility::getStruct("gauntlet_lower_center", "script_noteworthy");

  for(;;) {
    foreach(player in level.players) {
      if(distance2d(player.origin, marker.origin) <= marker.radius) {
        level thread _id_C2D3A49F3D8B0AB8(["planter_right", "planter_left"], 10);
        return;
      }
    }

    wait 1;
  }
}

_id_C2D3A49F3D8B0AB8(_id_09500F7593EECCC8, _id_92A110742776E2F8) {
  level endon("game_ended");
  _id_28F8F60414DFB888 = level._id_B3826A903E994BA3;

  if(isDefined(_id_28F8F60414DFB888)) {
    _id_28F8F60414DFB888 endon("starting_revenge_sequence");

    if(istrue(_id_28F8F60414DFB888._id_979B7E2496150E35))
      return;
  }

  level thread _id_18AF78602B67B70C::_id_775CD164C569E279("dx_guid42c24da0ffa74d29a9501eab5a0748c9");

  foreach(group in _id_09500F7593EECCC8) {
    level thread _id_18A73A64992DD07D::run_spawn_module(group);
    wait(_id_92A110742776E2F8);
  }
}

_id_EF454B7265586BAF(triggers) {
  level endon("game_ended");
  level endon("vtol_destroyed");
  _id_878914B0358BC7B5 = 1;

  while(istrue(_id_878914B0358BC7B5)) {
    _id_878914B0358BC7B5 = 0;

    foreach(trigger in triggers) {
      foreach(player in level.players) {
        if(player istouching(trigger)) {
          _id_878914B0358BC7B5 = 1;
          continue;
        }
      }
    }

    wait 1;
  }
}

_id_DE534AAC8FBD1604() {
  level endon("game_ended");
  level endon("vtol_destroyed");
  trigger = self;
  _id_878914B0358BC7B5 = 1;

  while(istrue(_id_878914B0358BC7B5)) {
    _id_878914B0358BC7B5 = 0;

    foreach(player in level.players) {
      if(player istouching(trigger)) {
        _id_878914B0358BC7B5 = 1;
        continue;
      }
    }

    wait 1;
  }
}

_id_0C31FC00A1F0BCBA() {
  level endon("game_ended");
  level endon("vtol_destroyed");
  trigger = getEnt("gauntlet_roof_trigger", "script_noteworthy");

  if(!isDefined(trigger)) {
    return;
  }
  _id_0C544E08073C5DF1 = 0;
  _id_A1757D6838931CDA = 20;

  for(;;) {
    trigger waittill("trigger", player);

    if(!isPlayer(player)) {
      wait 1;
      continue;
    }

    _id_0C544E08073C5DF1 = 0;

    while(player istouching(trigger)) {
      _id_0C544E08073C5DF1++;

      if(_id_0C544E08073C5DF1 >= _id_A1757D6838931CDA) {
        _id_72DAC79A97FC7C5C = scripts\engine\utility::getStruct("heli_infils_roof_1", "script_noteworthy");

        if(!isDefined(_id_72DAC79A97FC7C5C)) {
          return;
        }
        spawners = scripts\engine\utility::getStructArray("heli_squad_roof_1", "targetname");
        level thread scripts\cp\cp_spawning_util::_id_94E3A9862B435632(_id_72DAC79A97FC7C5C, spawners);
        level waittill("loaded_ai_in_vehicle", vehicle);

        if(isDefined(vehicle) && isDefined(vehicle.riders)) {
          foreach(rider in vehicle.riders)
          rider thread _id_B30244EF9B2F5F28();
        }

        _id_0C544E08073C5DF1 = 0;
        trigger _id_DE534AAC8FBD1604();
      }

      wait 1;
    }

    wait 1;
  }
}

_id_D75A2FF664E414F2(_id_090C9404021914DE, _id_4C0A0BC08175E9A0, _id_4C0A0EC08175F039, _id_4C0A0DC08175EE06, _id_42918A7AEF608CCB) {
  level endon("game_ended");
  level endon("vtol_destroyed");
  trigger = getEnt(_id_090C9404021914DE, "targetname");

  if(!isDefined(trigger)) {
    return;
  }
  for(;;) {
    trigger waittill("trigger", player);
    _id_211EBCD5F4CCC9AE = _id_E2A11290273A7ED4();

    if(_id_211EBCD5F4CCC9AE.size >= 15) {
      continue;
    }
    if(isPlayer(player) && isalive(player)) {
      level notify("gauntlet_burst_spawn");
      _id_30AB2A49CCE8FB24 = _id_4C0A0BC08175E9A0;

      switch (randomint(3)) {
        case 0:
          _id_30AB2A49CCE8FB24 = _id_4C0A0BC08175E9A0;
          break;
        case 1:
          _id_30AB2A49CCE8FB24 = _id_4C0A0EC08175F039;
          break;
        case 2:
          _id_30AB2A49CCE8FB24 = _id_4C0A0DC08175EE06;
          break;
        default:
          _id_30AB2A49CCE8FB24 = _id_4C0A0BC08175E9A0;
          break;
      }

      foreach(spawngroup in _id_30AB2A49CCE8FB24) {
        if(spawngroup == "gauntlet_ledge_spawner") {
          _id_44C998E27E126507 = _id_18A73A64992DD07D::get_spawned_ai_from_group_struct("gauntlet_ledge_spawner");

          if(!isDefined(_id_44C998E27E126507) || _id_44C998E27E126507.size <= 1)
            level thread _id_18A73A64992DD07D::run_spawn_module(spawngroup);
        } else
          level thread _id_18A73A64992DD07D::run_spawn_module(spawngroup);

        wait 0.1;
      }

      if(!istrue(level._id_1FDCA23A95CA5394)) {
        level._id_1FDCA23A95CA5394 = 1;

        foreach(_id_7649A1A6A41EA37A in _id_42918A7AEF608CCB) {
          level thread _id_18A73A64992DD07D::run_spawn_module(_id_7649A1A6A41EA37A);
          wait 0.1;
        }
      }

      wait 5;
      _id_641F1AB7F4CD66AE = getEntArray("gauntlet_trigger", "script_noteworthy");
      level _id_EF454B7265586BAF(_id_641F1AB7F4CD66AE);
      wait 5;
      continue;
    }

    wait 1;
  }
}

_id_9BE7AD73B35E4038(_id_090C9404021914DE, spawngroup, cooldown, _id_1FC3FBB4B05256C3) {
  level endon("game_ended");
  level endon("vtol_destroyed");

  if(!isDefined(_id_1FC3FBB4B05256C3))
    _id_1FC3FBB4B05256C3 = 0;

  trigger = getEnt(_id_090C9404021914DE, "targetname");

  if(!isDefined(trigger)) {
    return;
  }
  for(;;) {
    trigger waittill("trigger", player);

    if(isPlayer(player) && isalive(player)) {
      level thread _id_18A73A64992DD07D::run_spawn_module(spawngroup);

      if(istrue(_id_1FC3FBB4B05256C3)) {
        _id_BC12D14073E16FB4 = isDefined(_id_B09E4B411E17684B());

        while(istrue(_id_BC12D14073E16FB4)) {
          wait(cooldown);
          _id_BC12D14073E16FB4 = isDefined(_id_B09E4B411E17684B());
          _id_211EBCD5F4CCC9AE = _id_E2A11290273A7ED4();

          if(istrue(_id_BC12D14073E16FB4) && _id_211EBCD5F4CCC9AE.size < 15)
            level thread _id_18A73A64992DD07D::run_spawn_module(spawngroup);
        }

        wait(cooldown);
        continue;
      } else {
        trigger _id_DE534AAC8FBD1604();
        wait(cooldown);
      }

      continue;
    }

    wait 0.5;
  }
}

_id_D0CA140D890B1423() {
  _id_3298854E6A655DA9 = getaiarray("axis");

  foreach(ai in _id_3298854E6A655DA9) {
    if(_id_A387A3A903F7DF2D("gauntlet_trigger", ai))
      _id_3298854E6A655DA9 = scripts\engine\utility::array_remove(_id_3298854E6A655DA9, ai);
  }

  return _id_3298854E6A655DA9;
}

_id_E2A11290273A7ED4() {
  _id_CD207438E3E764E6 = getaiarray("axis");
  _id_211EBCD5F4CCC9AE = [];

  foreach(ai in _id_CD207438E3E764E6) {
    if(_id_A387A3A903F7DF2D("gauntlet_trigger", ai))
      _id_211EBCD5F4CCC9AE[_id_211EBCD5F4CCC9AE.size] = ai;
  }

  return _id_211EBCD5F4CCC9AE;
}

_id_A9C167406F381EC1() {
  level endon("game_ended");
  level endon("vtol_destroyed");
  trigger = getEnt("sniper_spawn_trigger", "script_noteworthy");

  if(!isDefined(trigger)) {
    return;
  }
  for(;;) {
    trigger waittill("trigger", player);

    if(isPlayer(player) && isalive(player)) {
      level notify("spawn_gauntlet_snipers");
      wait 50;
      continue;
    }

    wait 0.5;
  }
}

_id_CA5D7791980E307B() {
  level thread _id_D75A2FF664E414F2("gauntlet_left_room_trigger", ["gauntlet_ledge_spawner", "gauntlet_left_room_3", "ambush_ledge_left", "gauntlet_center"], ["gauntlet_ledge_spawner", "gauntlet_left_room_1", "ambush_ledge_left", "gauntlet_center_1"], ["gauntlet_ledge_spawner", "gauntlet_left_room_2", "ambush_ledge_left", "gauntlet_center_2"], ["gauntlet_roof"]);
  level thread _id_D75A2FF664E414F2("gauntlet_right_room_trigger", ["gauntlet_ledge_spawner", "gauntlet_right_room_1", "ambush_ledge_left", "gauntlet_center"], ["gauntlet_ledge_spawner", "gauntlet_right_room_2", "ambush_ledge_left", "gauntlet_center_1"], ["gauntlet_ledge_spawner", "gauntlet_right_room_3", "ambush_ledge_left", "gauntlet_center_2"], ["gauntlet_roof"]);
  level thread _id_0C31FC00A1F0BCBA();
}

_id_134BE06B687594A8() {
  level endon("game_ended");
  level endon("vtol_destroyed");
  level thread _id_18A73A64992DD07D::run_spawn_module("gauntlet_trickle_sniper_1");
  level thread _id_18A73A64992DD07D::run_spawn_module("gauntlet_trickle_sniper_2");
}

_id_F14AB8184282CEE5() {
  _id_DE498D49DC2BE3B8 = [];

  foreach(player in level.players) {
    if(isplayeronground(player))
      _id_DE498D49DC2BE3B8[_id_DE498D49DC2BE3B8.size] = player;
  }

  return _id_DE498D49DC2BE3B8;
}

_id_FDA0738FDF2B3996() {
  _id_DE498D49DC2BE3B8 = [];

  foreach(player in level.players) {
    if(isplayeronground(player))
      _id_DE498D49DC2BE3B8[_id_DE498D49DC2BE3B8.size] = player;
  }

  return scripts\engine\utility::random(_id_DE498D49DC2BE3B8);
}

_id_532CEE6D5AB0FCD2() {
  if(!isDefined(level._id_B3826A903E994BA3))
    return 1;

  _id_C441021D447DE784 = ["flybyattack"];
  curstate = _id_37B1257733BFF5B9();
  _id_5F37C80CE3DD1A83 = istrue(level._id_B3826A903E994BA3._id_979B7E2496150E35) || istrue(level._id_A041C83B7BD74D22);
  return istrue(_id_5F37C80CE3DD1A83) || scripts\engine\utility::array_contains(_id_C441021D447DE784, curstate);
}

_id_51DD0969346E985E() {
  level endon("game_ended");
  level endon("vtol_destroyed");
  level notify("single_bomber_spawn_thread");
  level endon("single_bomber_spawn_thread");
  _id_6580B36D899B36F9 = 0;

  for(;;) {
    aicount = getaiarray("axis").size - _id_E2A11290273A7ED4().size;

    if(aicount >= 5 || _id_532CEE6D5AB0FCD2()) {
      wait 1;
      continue;
    }

    _id_6580B36D899B36F9++;

    if(_id_6580B36D899B36F9 >= 3) {
      level thread _id_5BB6E401A4299527();
      _id_6580B36D899B36F9 = 0;
    }

    _id_63C93B0EFEA447BF(1.3);
  }
}

_id_BCCEAE8D78EB76CA() {
  level endon("game_ended");
  level endon("vtol_destroyed");

  if(getdvarint("dvar_CD385F4320763B25", 0) > 0)
    level thread _id_51DD0969346E985E();

  _id_B599B93D4979F857 = 0;
  _id_FF069456B57E7887 = 0;
  _id_2102671DF220EB07 = 0;
  _id_EC2B3AABD75DB510 = 0;
  _id_64E7A9D8DB0D5B7B = 0;

  for(;;) {
    aicount = getaiarray("axis").size - _id_E2A11290273A7ED4().size;

    if(aicount >= 5 || _id_532CEE6D5AB0FCD2()) {
      wait 1;
      continue;
    }

    _id_2DD7D261755C8F68 = scripts\engine\utility::ter_op(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8(), 10, 5);

    if(istrue(_id_64E7A9D8DB0D5B7B) && (aicount < 3 || _id_EC2B3AABD75DB510 > _id_2DD7D261755C8F68)) {
      if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
        wait 22.5;
      else
        wait 45;

      _id_EC2B3AABD75DB510 = 0;
    }

    _id_64E7A9D8DB0D5B7B = 1;
    _id_2102671DF220EB07++;

    if(_id_B0DB7C2656C08DE8() > 1 && _id_2102671DF220EB07 >= 5) {
      _id_FF069456B57E7887 = 1;
      _id_2102671DF220EB07 = 0;
    }

    _id_261662C95A4EE139 = aicount <= 1;
    level _id_4E1FE953306A7FEC(_id_B599B93D4979F857, _id_261662C95A4EE139, undefined, _id_FF069456B57E7887);
    _id_B599B93D4979F857 = 0;
    _id_FF069456B57E7887 = 0;
    _id_63C93B0EFEA447BF();
    _id_EC2B3AABD75DB510++;
  }
}

_id_63C93B0EFEA447BF(_id_4ECF326BCA2DFD03) {
  level endon("game_ended");

  if(!isDefined(_id_4ECF326BCA2DFD03))
    _id_4ECF326BCA2DFD03 = 1;

  if(!isDefined(level._id_B3826A903E994BA3))
    wait 30;
  else {
    _id_17E2BE84FF0A3984 = _id_B0DB7C2656C08DE8();

    switch (_id_17E2BE84FF0A3984) {
      case 1:
      default:
        wait(30 * _id_4ECF326BCA2DFD03);
        break;
      case 2:
        wait(30 * _id_4ECF326BCA2DFD03);
        break;
      case 3:
        wait(20 * _id_4ECF326BCA2DFD03);
        break;
    }
  }
}

_id_97EF1E3F6FF66BBB() {
  self endon("death");
  level endon("game_ended");
  self endon("entered_death_sequence");
  starttime = gettime();
  endtime = gettime() + 3000;

  for(;;) {
    if(istrue(self._id_979B7E2496150E35)) {
      return;
    }
    if(!_id_BEA60A0EA24D485A()) {
      wait 3;
      continue;
    }

    if(gettime() > endtime) {
      return;
    }
    wait 1;
  }
}

_id_B27DB3DB0A9A956E(_id_61DD90FF44CE35DA) {
  level endon("game_ended");
  _id_61DD90FF44CE35DA endon("death");
  destinations = scripts\engine\utility::getStructArray("bunker_indoor_marker", "script_noteworthy");

  foreach(ai in getaiarray("axis")) {
    ai._id_9AF6866C153DC36D = ai.origin;
    ai._id_FAF05B58464C9E8A = ai.goalradius;
    ai.goalradius = 32;
    goal = scripts\engine\utility::random(destinations);
    ai setgoalpos(goal.origin);
  }

  _id_61DD90FF44CE35DA scripts\engine\utility::waittill_any_timeout_1(10, "flyby_attack_done");

  foreach(ai in getaiarray("axis")) {
    if(isDefined(ai._id_9AF6866C153DC36D)) {
      ai setgoalpos(ai._id_9AF6866C153DC36D);
      ai.goalradius = ai._id_FAF05B58464C9E8A;
    }
  }
}

_id_CC4CBFAA07AF1821(point) {
  _id_9C908DC9DBF1F5AD = 512;

  foreach(player in level.players) {
    if(distance2d(player.origin, point) <= _id_9C908DC9DBF1F5AD)
      return 1;
  }

  return 0;
}

_id_CC0488C5F6D1B7A9() {
  _id_E056309D8D9E19B5 = [2, 4];

  if(!isDefined(level._id_E880206E0CA46AD0))
    level._id_E880206E0CA46AD0 = 0;

  _id_185B7E0AAEED1904 = level._id_E880206E0CA46AD0 + 1;

  while(!scripts\engine\utility::array_contains(_id_E056309D8D9E19B5, _id_185B7E0AAEED1904)) {
    _id_185B7E0AAEED1904++;

    if(_id_185B7E0AAEED1904 > 4)
      _id_185B7E0AAEED1904 = 1;

    waitframe();
  }

  return _id_185B7E0AAEED1904;
}

_id_65B87008BD996604(_id_185B7E0AAEED1904) {
  _id_F2AF0F8E96B032E7 = &"CP_HARRIER_BOSS/SPAWNS_1";

  switch (_id_185B7E0AAEED1904) {
    case 1:
      _id_F2AF0F8E96B032E7 = &"CP_HARRIER_BOSS/SPAWNS_1";
      break;
    case 2:
      _id_F2AF0F8E96B032E7 = &"CP_HARRIER_BOSS/SPAWNS_2";
      break;
    case 3:
      _id_F2AF0F8E96B032E7 = &"CP_HARRIER_BOSS/SPAWNS_3";
      break;
    default:
      _id_F2AF0F8E96B032E7 = &"CP_HARRIER_BOSS/SPAWNS_4";
      break;
  }

  return _id_F2AF0F8E96B032E7;
}

_id_B0DB7C2656C08DE8() {
  if(!isDefined(level._id_1938257AED3C116A))
    level._id_1938257AED3C116A = 1;

  return level._id_1938257AED3C116A;
}

_id_C3366D655386A013(_id_78F17C4D60C49480) {
  _id_17E2BE84FF0A3984 = _id_B0DB7C2656C08DE8();
  _id_93D2575A5D8E3B39 = [];
  _id_B86DDD6C183B0D14 = [];
  _id_3BB09C7BBF07A057 = int(_id_17E2BE84FF0A3984 / _id_78F17C4D60C49480.size);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3BB09C7BBF07A057; _id_AC0E594AC96AA3A8++)
    _id_93D2575A5D8E3B39[_id_93D2575A5D8E3B39.size] = scripts\engine\utility::random(_id_78F17C4D60C49480) + "B";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_78F17C4D60C49480.size; _id_AC0E594AC96AA3A8++) {
    if(!scripts\engine\utility::array_contains(_id_93D2575A5D8E3B39, _id_78F17C4D60C49480[_id_AC0E594AC96AA3A8]))
      _id_B86DDD6C183B0D14[_id_B86DDD6C183B0D14.size] = _id_78F17C4D60C49480[_id_AC0E594AC96AA3A8] + "A";
  }

  return scripts\cp\utility::array_merge(_id_93D2575A5D8E3B39, _id_B86DDD6C183B0D14);
}

_id_E73ABEBC6ED4BE65(_id_185B7E0AAEED1904, _id_C229C08AF97C7180) {
  _id_1F8B534609C32308 = ["ar_" + _id_185B7E0AAEED1904 + "_", "shotgun_" + _id_185B7E0AAEED1904 + "_", "smg_" + _id_185B7E0AAEED1904 + "_"];
  _id_1F8B534609C32308 = scripts\engine\utility::array_randomize(_id_1F8B534609C32308);
  _id_67CEC96F8049FC76 = [];
  _id_CD51AB4357F76C8C = min(4, _id_1F8B534609C32308.size);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_CD51AB4357F76C8C; _id_AC0E594AC96AA3A8++)
    _id_67CEC96F8049FC76[_id_AC0E594AC96AA3A8] = _id_1F8B534609C32308[_id_AC0E594AC96AA3A8];

  groups = _id_C3366D655386A013(_id_67CEC96F8049FC76);

  if(istrue(_id_C229C08AF97C7180))
    groups[groups.size] = "jugg_" + _id_185B7E0AAEED1904;

  return groups;
}

_id_4E1FE953306A7FEC(_id_C229C08AF97C7180, _id_261662C95A4EE139, _id_8D7B72A5BAB25CF1, _id_FF069456B57E7887) {
  _id_185B7E0AAEED1904 = _id_CC0488C5F6D1B7A9();

  if(!isDefined(_id_261662C95A4EE139))
    _id_261662C95A4EE139 = 0;

  _id_86E217C904305A72 = "ar_" + _id_185B7E0AAEED1904;
  _id_D8A5FBC726EB9176 = "smg_" + _id_185B7E0AAEED1904;
  _id_419BDAF51DB0148B = "shotgun_" + _id_185B7E0AAEED1904;
  _id_A723E8387215C985 = "jugg_" + _id_185B7E0AAEED1904;
  _id_D89358D03E05F7EF = "planter_left";
  _id_CA217AE129509635 = "planter_right";
  _id_5832FB9FB731943C = _id_18A73A64992DD07D::get_module_struct_from_level(_id_86E217C904305A72 + "_A");
  _id_F915DB8077887A30 = _id_18A73A64992DD07D::get_module_struct_from_level(_id_D8A5FBC726EB9176 + "_A");
  _id_2C272CF7187120D1 = _id_18A73A64992DD07D::get_module_struct_from_level(_id_419BDAF51DB0148B + "_A");
  _id_EF31C2DDFD9709DA = _id_18A73A64992DD07D::get_module_struct_from_level(_id_A723E8387215C985);
  _id_71D1376DA4911EE5 = _id_18A73A64992DD07D::get_module_struct_from_level(_id_D89358D03E05F7EF);
  _id_AFA04134F62386E3 = _id_18A73A64992DD07D::get_module_struct_from_level(_id_CA217AE129509635);
  _id_8A52520CE1A05C16 = getaiarray("axis").size;
  _id_350FC69B17797361 = _id_5832FB9FB731943C.totalspawns + _id_F915DB8077887A30.totalspawns + _id_2C272CF7187120D1.totalspawns;

  if(istrue(_id_261662C95A4EE139))
    _id_350FC69B17797361 = _id_350FC69B17797361 * 2;

  _id_F2AF0F8E96B032E7 = _id_65B87008BD996604(_id_185B7E0AAEED1904);

  if(istrue(_id_C229C08AF97C7180))
    _id_350FC69B17797361 = _id_350FC69B17797361 + _id_EF31C2DDFD9709DA.totalspawns;

  if(istrue(_id_8D7B72A5BAB25CF1))
    _id_350FC69B17797361 = _id_350FC69B17797361 + (_id_71D1376DA4911EE5.totalspawns + _id_AFA04134F62386E3.totalspawns);

  if(_id_8A52520CE1A05C16 + _id_350FC69B17797361 <= 30) {
    thread scripts\cp\utility::cp_add_dialogue_line(_id_F2AF0F8E96B032E7);
    thread _id_18AF78602B67B70C::_id_775CD164C569E279(_id_54CD2F136875A449(_id_185B7E0AAEED1904));
    _id_30AB2A49CCE8FB24 = _id_E73ABEBC6ED4BE65(_id_185B7E0AAEED1904, _id_C229C08AF97C7180);

    foreach(group in _id_30AB2A49CCE8FB24) {
      level thread _id_18A73A64992DD07D::run_spawn_module(group);
      wait 0.3;

      if(istrue(_id_261662C95A4EE139)) {
        level thread _id_18A73A64992DD07D::run_spawn_module(group);
        wait 0.3;
      }
    }

    if(istrue(_id_8D7B72A5BAB25CF1))
      level thread _id_5BB6E401A4299527();

    if(istrue(_id_FF069456B57E7887))
      level thread _id_D96E070433D9444B();

    level._id_E880206E0CA46AD0 = _id_185B7E0AAEED1904;
  }
}

_id_D96E070433D9444B() {
  _id_C979C52508EAC96C = randomintrange(1, 3);
  level thread _id_18A73A64992DD07D::run_spawn_module("riotshield_" + _id_C979C52508EAC96C);
  level thread _id_18A73A64992DD07D::run_spawn_module("shieldsupport_" + _id_C979C52508EAC96C);
}

_id_5BB6E401A4299527() {
  _id_52F9B3F7B5F1372C = _id_B0DB7C2656C08DE8();
  _id_67CEC96F8049FC76 = [];
  _id_62EFCD976FE84759 = 1;

  switch (_id_52F9B3F7B5F1372C) {
    case 0:
    default:
      _id_67CEC96F8049FC76 = ["planter_right", "planter_left"];
      _id_62EFCD976FE84759 = 1;
      break;
    case 1:
      _id_67CEC96F8049FC76 = ["planter_right", "planter_left", "backplanter_right", "backplanter_left"];
      _id_62EFCD976FE84759 = randomintrange(1, 3);
      break;
    case 2:
      _id_67CEC96F8049FC76 = ["backplanter_right", "backplanter_left", "planter_armor_right", "planter_armor_left"];
      _id_62EFCD976FE84759 = randomintrange(2, 4);
      break;
    case 3:
      _id_67CEC96F8049FC76 = ["backplanter_right", "backplanter_left", "planter_armor_right", "planter_armor_left", "bomber_jugg_right", "bomber_jugg_left"];
      _id_62EFCD976FE84759 = randomintrange(3, 5);
      break;
  }

  _id_E4B2180811C40E0B = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_62EFCD976FE84759; _id_AC0E594AC96AA3A8++)
    _id_E4B2180811C40E0B[_id_E4B2180811C40E0B.size] = scripts\engine\utility::random(_id_67CEC96F8049FC76);

  level thread _id_C2D3A49F3D8B0AB8(_id_E4B2180811C40E0B, randomintrange(2, 5));
}

_id_54CD2F136875A449(_id_185B7E0AAEED1904) {
  _id_F2AF0F8E96B032E7 = "";

  switch (_id_185B7E0AAEED1904) {
    case 1:
      _id_F2AF0F8E96B032E7 = "dx_guidcd348c7b745440a9b388b23927d0a007";
      break;
    case 2:
      _id_F2AF0F8E96B032E7 = "dx_guid8908141effe5401f95cc223abdae5eba";
      break;
    case 3:
      _id_F2AF0F8E96B032E7 = "dx_guidf7950be0492849d6896e88d7736a15e6";
      break;
    default:
      _id_F2AF0F8E96B032E7 = "dx_guid5b5f5e179bfe42e2861b75b223b60504";
      break;
  }

  return _id_F2AF0F8E96B032E7;
}

_id_BEA60A0EA24D485A() {
  state = _id_37B1257733BFF5B9();
  _id_098312A800924093 = ["intro", "dazed", "aggroed", "clearingroof", "dying", "deathblow", "flybyattack", "waitingtoreturn", "destroying_gauntlet"];

  if(scripts\engine\utility::array_contains(_id_098312A800924093, state))
    return 0;
  else
    return 1;
}

_id_342E98C80EC01FDF(point) {
  volumes = [];
  volumes = scripts\cp\utility::array_merge(volumes, getEntArray("gauntlet_trigger", "script_noteworthy"));
  volumes = scripts\cp\utility::array_merge(volumes, getEntArray("basement_trigger", "script_noteworthy"));
  volumes = scripts\cp\utility::array_merge(volumes, getEntArray("vtol_nofly_zone", "script_noteworthy"));

  foreach(vol in volumes) {
    if(ispointinvolume(point, vol))
      return 0;
  }

  return 1;
}

_id_05428B136D0D57D7() {
  level endon("game_ended");
  level endon("vtol_destroyed");

  for(;;) {
    level waittill("try_vtol_aggro_change_vo");
    thread scripts\cp\utility::cp_add_dialogue_line(&"CP_HARRIER_BOSS/CHANGE_TARGETS");
    thread _id_18AF78602B67B70C::_id_775CD164C569E279("dx_guidf91d33cea8cd47c8b3a2c1b655c480d7");
    wait 8;
  }
}

_id_EE5603F0E44CE971(player) {
  level endon("game_ended");
  level endon("vtol_destroyed");
  _id_61DD90FF44CE35DA = level._id_B3826A903E994BA3;
  _id_61DD90FF44CE35DA endon("death");
  _id_61DD90FF44CE35DA endon("entered_death_sequence");
  _id_61DD90FF44CE35DA notify("entered_aggro_phase");
  _id_61DD90FF44CE35DA notify("end_standard_attack");
  _id_61DD90FF44CE35DA endon("entered_aggro_phase");
  _id_61DD90FF44CE35DA._id_983C6A727F5D4DEF = "aggroed";
  _id_61DD90FF44CE35DA notify("turn_off_laser_vfx");
  starttime = gettime();
  _id_9FEDD168EC86815C = min(player.origin[2] + 600, 1800);
  goalpos = (player.origin[0], player.origin[1], _id_9FEDD168EC86815C);
  level notify("try_vtol_aggro_change_vo");

  if(_id_E7E9484F58943309(player)) {
    goalpos = scripts\engine\utility::getStruct("harrier_hoverspot_1", "script_noteworthy").origin;
    goalpos = (goalpos[0], goalpos[0], _id_9FEDD168EC86815C);
  }

  _id_61DD90FF44CE35DA setmaxpitchroll(30, 10);
  _id_61DD90FF44CE35DA setneargoalnotifydist(512);
  _id_61DD90FF44CE35DA setlookatent(player);
  _id_61DD90FF44CE35DA sethoverparams(250, 100, 100);

  if(_id_342E98C80EC01FDF(goalpos)) {
    _id_61DD90FF44CE35DA vehicle_setspeed(25, 10, 10);
    _id_61DD90FF44CE35DA setvehgoalpos(goalpos, 1);
  } else {
    _id_61DD90FF44CE35DA vehicle_setspeed(2, 2, 2);
    _id_61DD90FF44CE35DA setvehgoalpos((_id_61DD90FF44CE35DA.origin[0], _id_61DD90FF44CE35DA.origin[1], _id_9FEDD168EC86815C), 1);
  }

  _id_61DD90FF44CE35DA thread _id_4764615B7D1A6915(_id_61DD90FF44CE35DA, player);

  if(getdvarint("dvar_294C505B2EF6B594", 0) > 0)
    _id_61DD90FF44CE35DA thread _id_6155181263E53912(_id_61DD90FF44CE35DA, player, "harrier_green_laser");

  _id_61DD90FF44CE35DA _id_301B440AEDC838CF("breach_warning_beep_02", player, 4);
  _id_61DD90FF44CE35DA thread _id_F41D3ED5777FC07D(player, "aggroed", 2, 2);
  _id_EE226C3099286E05 = getdvarint("dvar_3D5D41BAA883D563", 30);

  while(gettime() - starttime < _id_EE226C3099286E05 * 1000)
    waitframe();

  _id_61DD90FF44CE35DA notify("turn_off_laser_vfx");
  _id_61DD90FF44CE35DA._id_983C6A727F5D4DEF = "idle";
  _id_61DD90FF44CE35DA clearlookatent();
}

_id_AF20D5BF45A91F86(player, _id_8C06DA331873F4E6) {
  if(!isDefined(_id_8C06DA331873F4E6))
    _id_8C06DA331873F4E6 = 64;

  startpoint = player.origin;
  endpoint = scripts\cp\utility::get_point_in_local_ent_space(player, (_id_8C06DA331873F4E6, 0, 0));
  success = sighttracepassed(startpoint, endpoint, 0, undefined);
  return success;
}

_id_C7E65E5884640D2C(_id_61DD90FF44CE35DA, player) {
  _id_0AECC8DACC19CF9B = 1024;
  _id_02B546C84812E4E6 = abs(_id_61DD90FF44CE35DA.origin[2] - player.origin[2]);
  _id_1A8097F1A065C786 = scripts\cp\utility::get_point_in_local_ent_space(player, (0, _id_0AECC8DACC19CF9B, _id_02B546C84812E4E6));
  _id_1A2A7C570678A79D = scripts\cp\utility::get_point_in_local_ent_space(player, (0, _id_0AECC8DACC19CF9B * -1, _id_02B546C84812E4E6));

  if(sighttracepassed(_id_1A8097F1A065C786, player.origin, 0, undefined) && _id_342E98C80EC01FDF(_id_1A8097F1A065C786))
    return _id_1A8097F1A065C786;
  else if(_id_342E98C80EC01FDF(_id_1A2A7C570678A79D))
    return _id_1A2A7C570678A79D;

  return undefined;
}

_id_E7E9484F58943309(player) {
  _id_D6C2716D2A0C9D56 = _id_A387A3A903F7DF2D("gauntlet_trigger", player) || _id_A387A3A903F7DF2D("basement_trigger", player) || _id_A387A3A903F7DF2D("bunker_trigger", player) || _id_A387A3A903F7DF2D("low_ledge_trigger", player);
  return _id_D6C2716D2A0C9D56;
}

_id_35ADCF435D5BFEF4(_id_61DD90FF44CE35DA, player) {
  _id_A9D0100ACE8DFC72 = _id_A387A3A903F7DF2D("gauntlet_trigger", player) || _id_A387A3A903F7DF2D("basement_trigger", player) || _id_A387A3A903F7DF2D("bunker_trigger", player) || _id_A387A3A903F7DF2D("low_ledge_trigger", player);
  _id_D5BCF737C2520653 = sighttracepassed(_id_61DD90FF44CE35DA.origin, player.origin, 0, _id_61DD90FF44CE35DA);

  if(istrue(_id_A9D0100ACE8DFC72) || _id_D5BCF737C2520653)
    return 0;

  _id_3DC36AA503991F8E = _id_AF20D5BF45A91F86(player);
  return _id_3DC36AA503991F8E;
}

_id_4764615B7D1A6915(_id_61DD90FF44CE35DA, player) {
  level endon("game_ended");
  level endon("vtol_destroyed");
  _id_61DD90FF44CE35DA endon("death");
  _id_61DD90FF44CE35DA endon("entered_aggro_phase");
  _id_61DD90FF44CE35DA endon("entered_death_sequence");
  player endon("death");
  player endon("last_stand");

  for(;;) {
    wait 3;

    if(_id_35ADCF435D5BFEF4(_id_61DD90FF44CE35DA, player)) {
      _id_6E281DBD69FC980E = _id_C7E65E5884640D2C(_id_61DD90FF44CE35DA, player);

      if(isDefined(_id_6E281DBD69FC980E))
        _id_61DD90FF44CE35DA setvehgoalpos(_id_6E281DBD69FC980E, 1);
    }

    wait 3;
  }
}

_id_0A28E52E4B0EF47A() {
  level endon("game_ended");
  level endon("vtol_destroyed");
  level._id_B3826A903E994BA3 endon("entered_death_sequence");
  level._id_B3826A903E994BA3 endon("death");
  _id_61DD90FF44CE35DA = level._id_B3826A903E994BA3;
  _id_61DD90FF44CE35DA._id_CA9F9B8A6CBE5B26 = 0;
  _id_61DD90FF44CE35DA._id_983C6A727F5D4DEF = "dazed";
  _id_61DD90FF44CE35DA notify("entered_daze_phase");
  _id_61DD90FF44CE35DA notify("turn_off_laser_vfx");
  _id_61DD90FF44CE35DA setvehgoalpos(_id_61DD90FF44CE35DA.origin, 1);
  _id_C395008E8CE7A870 = _id_B0DB7C2656C08DE8() + 1;
  level._id_1938257AED3C116A = _id_C395008E8CE7A870;
  _id_3C3C1D13A9BD05DE = 5;

  if(_id_C395008E8CE7A870 == 2) {
    level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_HARRIER_BOSS/ARMOR_WEAKENED");
    level thread _id_18AF78602B67B70C::_id_775CD164C569E279("dx_guidae5346777fca474981144fd7d95c7749");
  } else if(_id_C395008E8CE7A870 == 3) {
    thread scripts\cp\utility::cp_add_dialogue_line(&"CP_HARRIER_BOSS/ARMOR_GONE");
    level thread _id_18AF78602B67B70C::_id_775CD164C569E279("dx_guidde918a79857b4a82935229a1931a5ec2");
    level thread _id_FC2BC595A17094E2(_id_61DD90FF44CE35DA, "vfx_br_fire_plume", "tag_origin", "death", 5);
    _id_61DD90FF44CE35DA.health = 3000;
    _id_61DD90FF44CE35DA._id_5CA9F0AF73FA79A8 = 1;
    level thread _id_C1A50EEE024CA8FE(10);
    _id_3C3C1D13A9BD05DE = 15;
  }

  level thread _id_FC2BC595A17094E2(_id_61DD90FF44CE35DA, "jet_smoke1", "tag_flash", "returned_from_daze", 5);
  _id_61DD90FF44CE35DA thread _id_1D2CF6043F689D35(_id_61DD90FF44CE35DA);
  _id_61DD90FF44CE35DA scripts\engine\utility::waittill_any_timeout_1(_id_3C3C1D13A9BD05DE, "exit_daze_phase");

  if(getdvarint("dvar_5A3FF8238CC23B13", 1) > 0)
    _id_61DD90FF44CE35DA._id_979B7E2496150E35 = 1;

  wait 1;
  _id_61DD90FF44CE35DA._id_983C6A727F5D4DEF = "moving";
  _id_61DD90FF44CE35DA notify("returned_from_daze");
}

_id_C1A50EEE024CA8FE(interval) {
  level endon("game_ended");
  level endon("vtol_destroyed");

  for(;;) {
    wait(interval);

    if(isDefined(level._id_B3826A903E994BA3) && level._id_B3826A903E994BA3.health < 1500.0) {
      return;
    }
    foreach(player in level.players)
    player thread _id_721F01B9DF408A53(&"CP_HARRIER_BOSS/ARMOR_GONE");

    level thread _id_18AF78602B67B70C::_id_775CD164C569E279("dx_guidde918a79857b4a82935229a1931a5ec2");
  }
}

_id_1D2CF6043F689D35(_id_28F8F60414DFB888, state) {
  level endon("game_ended");
  _id_28F8F60414DFB888 endon("death");
  goalpos = scripts\cp\utility::get_point_in_local_ent_space(_id_28F8F60414DFB888, (0, 0, 200));
  _id_28F8F60414DFB888 clearlookatent();
  _id_28F8F60414DFB888 setturningability(1);
  _id_28F8F60414DFB888 setneargoalnotifydist(512);
  _id_28F8F60414DFB888 sethoverparams(250, 100, 100);
  _id_28F8F60414DFB888 vehicle_setspeed(200, 50, 50);
  _id_28F8F60414DFB888 setmaxpitchroll(30, 10);
  _id_28F8F60414DFB888 setvehgoalpos(goalpos);
  waitframe();

  if(!isDefined(state))
    state = "dazed";

  _id_1ECF4E6EFE8076D8 = 500;
  _id_28F8F60414DFB888 setyawspeed(_id_1ECF4E6EFE8076D8, 50, 50, 0.5);

  while(_id_37B1257733BFF5B9() == state) {
    _id_28F8F60414DFB888 settargetyaw(_id_28F8F60414DFB888.angles[1] + _id_1ECF4E6EFE8076D8 * 0.6);
    wait 0.5;
  }

  _id_28F8F60414DFB888 setyawspeed(45, 25, 25, 0.5);
  level notify("stop_rotating_lookat_ent");
}

_id_B7702BFE58424380(_id_5E782F6B349D27D5) {
  level endon("stop_rotating_lookat_ent");
  level._id_B3826A903E994BA3 endon("death");

  while(_id_37B1257733BFF5B9() == "dazed" && isDefined(_id_5E782F6B349D27D5)) {
    _id_5E782F6B349D27D5 rotateby((0, 360, 0), 3);
    wait 3;
  }
}

_id_852C653F24AB8A00(attacker) {
  result = 1;

  if(istrue(self._id_979B7E2496150E35) || istrue(level._id_A041C83B7BD74D22) || _id_37B1257733BFF5B9() == "dazed" || _id_37B1257733BFF5B9() == "flybyattack" || _id_37B1257733BFF5B9() == "waitingtoreturn" || !isDefined(attacker) || !isPlayer(attacker) || attacker istouching(self))
    result = 0;

  if(_id_37B1257733BFF5B9() == "clearingroof" && _id_A387A3A903F7DF2D("gauntlet_roof_trigger", attacker))
    return 0;

  return result;
}

_id_EE53706B30D63747(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, _id_799F234362ADB813, partname, eventid) {
  if(!isPlayer(attacker) || !istrue(self._id_5CA9F0AF73FA79A8))
    damage = 0;

  if(_id_37B1257733BFF5B9() == "deathblow") {
    damage = 99999;
    self.health = 100;
  }

  self vehicle_finishdamage(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, _id_799F234362ADB813, partname);

  if(self.health <= 0) {
    level notify("vtol_destroyed");
    thread scripts\cp\utility::cp_add_dialogue_line(&"CP_HARRIER_BOSS/DEATH");

    if(isDefined(self.pilot.head))
      self.pilot.head delete();

    if(isDefined(self.pilot))
      self.pilot delete();

    self delete();
    return;
  }

  if(istrue(self._id_5DCF52C778D87B1A)) {
    return;
  }
  thread _id_28E3575975332B75(attacker);
}

_id_28E3575975332B75(player) {
  level endon("game_ended");
  self endon("death");

  if(!_id_852C653F24AB8A00(player)) {
    return;
  }
  if(!isDefined(self._id_23C44A0944252197))
    self._id_23C44A0944252197 = 0;

  if(!isDefined(player._id_87DEBE6220839359))
    player._id_87DEBE6220839359 = 0;

  if(gettime() > self._id_23C44A0944252197 + 3000 && gettime() > player._id_87DEBE6220839359 + 3000 && distance(player.origin, self gettagorigin("tag_pilot")) > 400) {
    self._id_23C44A0944252197 = gettime();
    player._id_87DEBE6220839359 = gettime();
    self notify("aggroed_by_player", player);
    thread _id_EE5603F0E44CE971(player);
  }
}

_id_39ED3E75FE7DBD15(_id_61DD90FF44CE35DA, attacker) {
  level endon("game_ended");
  _id_61DD90FF44CE35DA notify("harrier_single_death_spin");
  _id_61DD90FF44CE35DA endon("harrier_single_death_spin");
  _id_61DD90FF44CE35DA endon("death");
  _id_61DD90FF44CE35DA._id_983C6A727F5D4DEF = "dying";
  wait 0.5;
  level thread _id_FC2BC595A17094E2(_id_61DD90FF44CE35DA, "jet_smoke1", "tag_origin", "death", 5);
  _id_61DD90FF44CE35DA thread _id_1D2CF6043F689D35(_id_61DD90FF44CE35DA, "dying");
  wait 4;
  _id_61DD90FF44CE35DA._id_5DCF52C778D87B1A = 1;
  waitframe();
  level thread _id_1EA49C02914C4D4C(_id_61DD90FF44CE35DA.origin, _id_61DD90FF44CE35DA.angles);
  _id_61DD90FF44CE35DA._id_983C6A727F5D4DEF = "deathblow";
  _id_61DD90FF44CE35DA dodamage(_id_61DD90FF44CE35DA.health * 2, attacker.origin, attacker, attacker getcurrentweapon(), "MOD_PROJECTILE");
}

_id_1EA49C02914C4D4C(_id_58D0A7F2D5484FFC, _id_7060C2C1D2237A3E) {
  level endon("game_ended");
  _id_EFDFC6EBE7A152C5 = spawnfx(level._effect["breach_explode"], _id_58D0A7F2D5484FFC, anglesToForward(_id_7060C2C1D2237A3E) * -1.0, (0, 0, 1));
  triggerfx(_id_EFDFC6EBE7A152C5);

  if(soundexists("breach_c4_expl_trans"))
    playsoundatpos(_id_58D0A7F2D5484FFC, "breach_c4_expl_trans");

  wait 2;
  _id_EFDFC6EBE7A152C5 delete();
}

_id_721F01B9DF408A53(message) {
  self endon("death");
  self endon("disconnect");

  if(!isPlayer(self) || istrue(self._id_242038D0AC97ED89)) {
    return;
  }
  self._id_242038D0AC97ED89 = 1;
  scripts\cp\cp_hud_message::tutorialprint(message, 2);
  wait 2;
  self._id_242038D0AC97ED89 = undefined;
}

_id_D5877D44FF6BEBFE(_id_B4DB2904F3EA3821) {
  index = _id_B4DB2904F3EA3821.script_noteworthy[_id_B4DB2904F3EA3821.script_noteworthy.size - 1];
  _id_C9E75DC99FEF9F93 = getEntArray("hover_dangerarea_" + index, "script_noteworthy");

  foreach(ent in _id_C9E75DC99FEF9F93)
  ent show();
}

_id_A960C2C12D3B9E16() {
  _id_C9E75DC99FEF9F93 = [];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++)
    _id_C9E75DC99FEF9F93 = scripts\cp\utility::array_merge(_id_C9E75DC99FEF9F93, getEntArray("hover_dangerarea_" + _id_AC0E594AC96AA3A8, "script_noteworthy"));

  foreach(ent in _id_C9E75DC99FEF9F93)
  ent hide();
}

_id_5F3189B8E8272C3E() {
  self endon("death");
  level endon("game_ended");
  self endon("entered_daze_phase");
  self endon("entered_aggro_phase");
  self endon("entered_death_sequence");
  self endon("entered_clearingroof_phase");
  self endon("starting_revenge_sequence");

  if(!_id_BEA60A0EA24D485A()) {
    return;
  }
  thread _id_9391ECC88B88A745();
  self._id_08B04DA884ED634A = "hoverattack";
  self._id_983C6A727F5D4DEF = "moving";
  targetplayer = _id_982218409E2A9FB9();
  _id_5B2DBB101C52D038 = scripts\engine\utility::getStruct("harrier_return_spot_2", "script_noteworthy");
  self vehicle_setspeed(200, 100, 100);
  self setvehgoalpos(_id_5B2DBB101C52D038.origin, 1);

  if(isDefined(targetplayer) && isalive(targetplayer))
    self setlookatent(targetplayer);

  scripts\engine\utility::waittill_any_timeout_2(2, "goal", "goal_reached");
  wait 0.5;
  _id_5CB924C7B6FE9D3D = _id_2B4A18A09958611B(targetplayer);

  if(!isDefined(_id_5CB924C7B6FE9D3D)) {
    wait 2;
    return;
  }

  self vehicle_setspeed(200, 100, 100);
  wait 2.0;
  self setvehgoalpos(_id_5CB924C7B6FE9D3D.origin, 1);
  self setlookatent(_id_5CB924C7B6FE9D3D._id_DD7C32625FEBF52E);
  self._id_1FE1D2894BB0D9E9 = _id_5CB924C7B6FE9D3D;
  iprintlnbold("moving to hover spot " + _id_5CB924C7B6FE9D3D.index);
  self sethoverparams(40, 25, 10);
  scripts\engine\utility::waittill_any_timeout_2(50, "goal", "goal_reached");
  self notify("turn_off_laser_vfx");
  iprintlnbold("HOVER_ATTACK");
  self setmaxpitchroll(30, 10);
  self sethoverparams(0, 20, 6);
  self vehicle_setspeed(1, 1, 1);
  wait 2;
  self._id_983C6A727F5D4DEF = "hoverattack";
  _id_A18FD119C17C71F9 = _id_3BA9CC0B75512A54(_id_5CB924C7B6FE9D3D);

  if(_id_A18FD119C17C71F9.size > 0)
    thread _id_4682BA1B427D1076(scripts\engine\utility::random(_id_A18FD119C17C71F9), _id_5CB924C7B6FE9D3D);

  endtime = gettime() + 10000;
  _id_3FEB7FA156DFCA02 = gettime() + 4000;

  while(!_id_452E49D1C2ED6B62(_id_5CB924C7B6FE9D3D) && gettime() <= endtime)
    wait 1;

  while(gettime() <= _id_3FEB7FA156DFCA02)
    wait 0.5;

  self vehicle_setspeed(10, 50, 50);
  _id_A960C2C12D3B9E16();
  _id_7A49AEE6918670C4();
  self notify("finished_hover_attack");
  self._id_983C6A727F5D4DEF = "idle";
  self clearlookatent();
}

_id_4D9EE6400B8CF346() {
  level endon("game_ended");
  self endon("death");
  self endon("finished_standard_attack");
  scripts\engine\utility::waittill_any_4("entered_daze_phase", "entered_aggro_phase", "entered_death_sequence", "entered_clearingroof_phase");
  self notify("turn_off_laser_vfx");
}

_id_9391ECC88B88A745() {
  level endon("game_ended");
  self endon("death");
  self endon("finished_hover_attack");
  scripts\engine\utility::waittill_any_4("entered_daze_phase", "entered_aggro_phase", "entered_death_sequence", "entered_clearingroof_phase");
  self notify("turn_off_laser_vfx");
  _id_A960C2C12D3B9E16();
  _id_7A49AEE6918670C4();
}

_id_452E49D1C2ED6B62(_id_0C3EA9B1A20FF199) {
  foreach(player in level.players) {
    if(isalive(player) && _id_15C391925185D1AB(player, _id_0C3EA9B1A20FF199))
      return 0;
  }

  return 1;
}

_id_F41D3ED5777FC07D(player, _id_8F4892BCD60E845E, _id_7E829D6BDFC498AD, _id_01B2B714E96FE27A) {
  self endon("death");
  self endon("entered_daze_phase");
  self endon("entered_aggro_phase");
  self endon("end_standard_attack");
  self endon("entered_death_sequence");
  self endon("entered_clearingroof_phase");
  self endon("starting_revenge_sequence");

  if(isPlayer(player) && player scripts\cp\utility::_hasperk("specialty_covert_ops"))
    wait 2;

  _id_716F5F843F9AC1C6 = makeweapon("hover_jet_turret_cp");
  _id_2C90EA28723E0BF7 = weaponfiretime(_id_716F5F843F9AC1C6);
  self setlookatent(player);
  _id_7E829D6BDFC498AD = _id_7E829D6BDFC498AD * 1000;
  wait 0.5;
  start_time = gettime();
  _id_77A5F517FA4DAB82 = spawn("script_model", scripts\cp\utility::get_point_in_local_ent_space(player, (200, 0, 0)));
  _id_77A5F517FA4DAB82 setModel("tag_origin");

  foreach(turret in self.turrets)
  turret snaptotargetentity(_id_77A5F517FA4DAB82);

  thread _id_2580E9D122DE6222(_id_77A5F517FA4DAB82, player, self, 0.5);
  thread _id_7F9723CF50A678A3(_id_77A5F517FA4DAB82, "end_standard_attack", "finished_std_attack");

  while(!_id_0AFB7E332AEE4BF2::player_in_laststand(player) && isalive(player) && _id_37B1257733BFF5B9() == _id_8F4892BCD60E845E) {
    if(!_id_982B88F4BE64DF48(player) || player.origin[2] > self.origin[2]) {
      waitframe();
      continue;
    }

    foreach(turret in self.turrets)
    turret shootturret();

    if(gettime() - start_time <= _id_7E829D6BDFC498AD) {
      wait(_id_2C90EA28723E0BF7 * 3);
      continue;
    }

    wait(_id_01B2B714E96FE27A);
    start_time = gettime();
  }

  self notify("finished_std_attack");
  self clearlookatent();
}

_id_2580E9D122DE6222(targetent, player, _id_28F8F60414DFB888, _id_222A4776B9655B51) {
  level endon("game_ended");
  _id_28F8F60414DFB888 endon("death");
  targetent endon("death");
  player endon("death");
  player endon("disconnect");
  _id_DF8E0358F6E2B842 = distance(targetent.origin, player.origin);
  _id_636C8575D7A7768B = 8;

  while(_id_DF8E0358F6E2B842 > _id_636C8575D7A7768B) {
    targetent moveTo(player.origin, _id_222A4776B9655B51);
    wait(_id_222A4776B9655B51);
  }

  targetent linkTo(player);
}

_id_7F9723CF50A678A3(ent, _id_27179F2C1F5463FC, _id_F72E570B97CAF5F5) {
  level endon("game_ended");
  self endon(_id_F72E570B97CAF5F5);
  scripts\engine\utility::waittill_any_2(_id_27179F2C1F5463FC, "entered_daze_phase");

  if(isDefined(ent))
    ent delete();
}

_id_4682BA1B427D1076(player, _id_0C3EA9B1A20FF199) {
  self endon("death");
  self endon("entered_daze_phase");
  self endon("entered_death_sequence");
  self endon("entered_clearingroof_phase");
  self endon("starting_revenge_sequence");

  if(isPlayer(player) && player scripts\cp\utility::_hasperk("specialty_covert_ops"))
    wait 2;

  _id_4F3025E97A04CBB5 = makeweapon("hover_jet_turret_cp");
  _id_2C90EA28723E0BF7 = weaponfiretime(_id_4F3025E97A04CBB5);
  targetent = player scripts\engine\utility::spawn_tag_origin();
  targetent linkTo(player, "j_wrist_le", (0, 0, 0), (0, 0, 0));

  foreach(turret in self.turrets)
  turret settargetentity(targetent, (0, 0, 0));

  _id_DDF68AD6E93DF929 = 1;
  _id_4BEBE5DF4F82FA55 = 0;

  while(!_id_0AFB7E332AEE4BF2::player_in_laststand(player) && isalive(player) && _id_15C391925185D1AB(player, _id_0C3EA9B1A20FF199) && _id_37B1257733BFF5B9() == "hoverattack") {
    if(_id_982B88F4BE64DF48(player)) {
      if(!istrue(_id_DDF68AD6E93DF929)) {
        _id_DDF68AD6E93DF929 = 1;
        targetent linkTo(player, "j_wrist_le", (0, 0, 0), (0, 0, 0));
      }

      foreach(turret in self.turrets)
      turret shootturret();

      wait(_id_2C90EA28723E0BF7);
      continue;
    }

    if(istrue(_id_DDF68AD6E93DF929)) {
      _id_DDF68AD6E93DF929 = 0;
      _id_4BEBE5DF4F82FA55 = gettime();
      targetent unlink();

      foreach(turret in self.turrets)
      turret shootturret();
    } else if(gettime() - _id_4BEBE5DF4F82FA55 <= 3000) {
      foreach(turret in self.turrets)
      turret shootturret();
    } else {}

    wait(_id_2C90EA28723E0BF7);
  }

  targetent delete();
}

_id_982B88F4BE64DF48(player) {
  _id_28F8F60414DFB888 = level._id_B3826A903E994BA3;
  passed = sighttracepassed(_id_28F8F60414DFB888 gettagorigin("tag_barrel_view"), player getEye(), 0, _id_28F8F60414DFB888, 1);
  return passed;
}

_id_3BA9CC0B75512A54(_id_0C3EA9B1A20FF199) {
  players = [];

  foreach(player in level.players) {
    if(_id_8AA148C1E2E416CF(player) && player istouching(_id_0C3EA9B1A20FF199._id_4E10555236D57214))
      players[players.size] = player;
  }

  return players;
}

_id_8EC9049CD6BB8968() {
  _id_31DC296EF231B362 = [];

  foreach(player in level.players) {
    if(_id_8AA148C1E2E416CF(player))
      _id_31DC296EF231B362[_id_31DC296EF231B362.size] = player;
  }

  if(_id_31DC296EF231B362.size <= 0)
    return undefined;

  return scripts\engine\utility::random(_id_31DC296EF231B362);
}

_id_982218409E2A9FB9() {
  level endon("game_ended");
  self endon("death");
  _id_31DC296EF231B362 = [];

  foreach(player in level.players) {
    if(_id_8AA148C1E2E416CF(player))
      _id_31DC296EF231B362[_id_31DC296EF231B362.size] = player;
  }

  if(_id_31DC296EF231B362.size == 0)
    return undefined;

  player = scripts\engine\utility::random(_id_31DC296EF231B362);
  return player;
}

_id_2B4A18A09958611B(player) {
  level endon("game_ended");
  self endon("death");

  if(!isDefined(player))
    player = _id_982218409E2A9FB9();

  if(!isDefined(player)) {
    return;
  }
  player endon("disconnect");
  player endon("death");

  if(!_id_BEA60A0EA24D485A()) {
    return;
  }
  _id_31DC296EF231B362 = [];

  foreach(player in level.players) {
    if(_id_8AA148C1E2E416CF(player))
      _id_31DC296EF231B362[_id_31DC296EF231B362.size] = player;
  }

  if(_id_31DC296EF231B362.size == 0)
    return undefined;

  player = scripts\engine\utility::random(_id_31DC296EF231B362);
  endtime = gettime() + 5000;
  _id_6280789993F86CE1 = 0;
  _id_F73DBE3CB6DD4F58 = player.origin;

  while(!istrue(_id_6280789993F86CE1) && _id_BEA60A0EA24D485A()) {
    if(gettime() >= endtime || !isalive(player))
      _id_6280789993F86CE1 = 1;

    _id_F73DBE3CB6DD4F58 = player.origin;
    wait 0.5;
  }

  _id_5CB924C7B6FE9D3D = undefined;

  foreach(_id_0C3EA9B1A20FF199 in level._id_B3826A903E994BA3._id_A83387E46C19DC56) {
    if(player istouching(_id_0C3EA9B1A20FF199._id_4E10555236D57214))
      _id_5CB924C7B6FE9D3D = _id_0C3EA9B1A20FF199;
  }

  if(!isDefined(_id_5CB924C7B6FE9D3D))
    _id_5CB924C7B6FE9D3D = scripts\engine\utility::random(level._id_B3826A903E994BA3._id_A83387E46C19DC56);

  return _id_5CB924C7B6FE9D3D;
}

_id_301B440AEDC838CF(alias, player, times) {
  level endon("game_ended");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < times; _id_AC0E594AC96AA3A8++) {
    self playsoundtoplayer(alias, player, player);
    wait 0.2;
  }
}

_id_5AFBAC4E0FB3AFBA(_id_28F8F60414DFB888, player, _id_60347FD2432F3A63) {
  level endon("game_ended");
  _id_28F8F60414DFB888 endon("stop_vfx_endent_monitor");

  for(;;) {
    _id_91D909023B49A0DF = physicstrace(_id_28F8F60414DFB888 gettagorigin("tag_barrel_view"), player.origin);
    _id_60347FD2432F3A63.origin = _id_91D909023B49A0DF;
    waitframe();
  }
}

_id_FC2BC595A17094E2(_id_28F8F60414DFB888, _id_84501ABDD5C427F0, _id_01CD1D08A3C2DB18, _id_374D7614ECBD032A, time) {
  level endon("game_ended");
  _id_28F8F60414DFB888 endon("death");
  vfxent = scripts\engine\utility::spawn_tag_origin(_id_28F8F60414DFB888 gettagorigin(_id_01CD1D08A3C2DB18), _id_28F8F60414DFB888 gettagangles(_id_01CD1D08A3C2DB18));
  wait 0.5;
  vfxent show();
  vfxent linkTo(_id_28F8F60414DFB888, "tag_barrel_view");
  waitframe();
  playFXOnTag(level._effect[_id_84501ABDD5C427F0], vfxent, "tag_origin");
  waitframe();
  vfxent show();
  _id_28F8F60414DFB888 scripts\engine\utility::waittill_any_timeout_1(time, _id_374D7614ECBD032A);
  vfxent delete();
}

_id_6155181263E53912(_id_28F8F60414DFB888, player, vfx) {
  level endon("game_ended");
  _id_60347FD2432F3A63 = player scripts\engine\utility::spawn_tag_origin();
  wait 1;
  _id_60347FD2432F3A63 show();
  _id_3CA3C728C3B34AB0 = playfxontagsbetweenclients(level._effect[vfx], _id_28F8F60414DFB888, "tag_barrel_view", _id_60347FD2432F3A63, "tag_origin");
  level thread _id_5AFBAC4E0FB3AFBA(_id_28F8F60414DFB888, player, _id_60347FD2432F3A63);
  scripts\engine\utility::waittill_any_ents(player, "last_stand", _id_28F8F60414DFB888, "death", _id_28F8F60414DFB888, "turn_off_laser_vfx", player, "disconnect");
  _id_28F8F60414DFB888 notify("stop_vfx_endent_monitor");
  _id_3CA3C728C3B34AB0 delete();
  _id_60347FD2432F3A63 delete();
}

_id_1EF85572D17F49EC(_id_88DA70B42BDB91D4, _id_F6D78C5BEF7A368B) {
  level endon("game_ended");
  _id_61DD90FF44CE35DA = self;
  endorigin = _id_F6D78C5BEF7A368B.origin;
  _id_F6D78C5BEF7A368B.origin = _id_88DA70B42BDB91D4;
  waitframe();
  _id_61DD90FF44CE35DA._id_5A5366AE0037B264[_id_61DD90FF44CE35DA._id_5A5366AE0037B264.size] = playfxontagsbetweenclients(level._effect["harrier_red_laser"], _id_61DD90FF44CE35DA, "tag_barrel_view", _id_F6D78C5BEF7A368B, "tag_origin");
  _id_F6D78C5BEF7A368B moveTo(endorigin, 4);
}

_id_51AACE6D836B8F5B() {
  _id_09364FA7563A95E0 = scripts\engine\utility::getStructArray("bunker_indoor_marker", "script_noteworthy");

  foreach(_id_AC0E594AC96AA3A8, marker in _id_09364FA7563A95E0) {
    marker._id_442990AD4662AB82 = "bunker_marker_" + _id_AC0E594AC96AA3A8;
    marker.objindex = scripts\cp\cp_objectives::requestworldid(marker._id_442990AD4662AB82);
    objective_state(marker.objindex, "current");
    objective_setzoffset(marker.objindex, 16);
    objective_position(marker.objindex, marker.origin);
    objective_icon(marker.objindex, "icon_waypoint_objective_general");
    objective_setminimapiconsize(marker.objindex, "icon_regular");
    objective_setshowdistance(marker.objindex, 1);
    objective_setplayintro(marker.objindex, 0);
    objective_sethot(marker.objindex, 1);
    objective_setbackground(marker.objindex, 0);
    objective_setlabel(marker.objindex, &"CP_HARRIER_BOSS/TAKE_COVER");
  }

  level scripts\engine\utility::waittill_any_2("vtol_destroyed", "flyby_attack_ended");

  foreach(_id_AC0E594AC96AA3A8, marker in _id_09364FA7563A95E0) {
    objective_delete(marker.objindex);
    scripts\cp\cp_objectives::freeworldid(marker._id_442990AD4662AB82);
  }
}

_id_AA2BABC5C4C55D94(_id_4D82B3F15401A771) {
  self endon("death");
  level endon("game_ended");
  self endon("entered_daze_phase");
  self endon("entered_death_sequence");
  self endon("entered_clearingroof_phase");
  self._id_983C6A727F5D4DEF = "flybyattack";
  self._id_08B04DA884ED634A = "flybyattack";
  _id_1BA0E552ED27BB6E = scripts\engine\utility::getStruct("harrier_flyby_takeoff", "script_noteworthy");
  startstruct = scripts\engine\utility::getStruct("harrier_flyby_start", "script_noteworthy");
  _id_D0697AF2ECA83D63 = scripts\engine\utility::getStruct("harrier_flyby_end", "script_noteworthy");
  self setmaxpitchroll(0, 0);

  if(!istrue(_id_4D82B3F15401A771)) {
    self vehicle_setspeed(100, 100, 150);
    self setlookatent(_id_1BA0E552ED27BB6E._id_9BC5CB3240D03C4C);
    self setvehgoalpos(_id_1BA0E552ED27BB6E.origin, 1);
    scripts\engine\utility::waittill_any_timeout_2(20, "goal", "goal_reached");
    thread scripts\cp\utility::cp_add_dialogue_line(&"CP_HARRIER_BOSS/FLYBY_TELL");
    level thread _id_18AF78602B67B70C::_id_775CD164C569E279("dx_guidd1cedcbe7f484d8d964b4a43f8d853ae");
    self setlookatent(startstruct._id_9BC5CB3240D03C4C);
    wait 3;
  } else {
    thread scripts\cp\utility::cp_add_dialogue_line(&"CP_HARRIER_BOSS/FLYBY_TELL");
    level thread _id_18AF78602B67B70C::_id_775CD164C569E279("dx_guidd1cedcbe7f484d8d964b4a43f8d853ae");
    self setlookatent(startstruct._id_9BC5CB3240D03C4C);
  }

  thread _id_51AACE6D836B8F5B();
  self setvehgoalpos(startstruct.origin, 1);
  scripts\engine\utility::waittill_any_timeout_2(20, "goal", "goal_reached");
  self sethoverparams(250, 100, 100);
  self vehicle_setspeed(10, 10, 10);
  self vehicle_setspeed(100, 100, 150);
  self setlookatent(_id_D0697AF2ECA83D63._id_9BC5CB3240D03C4C);

  if(!istrue(_id_4D82B3F15401A771))
    _id_62C4D0D07122F07D();
  else
    wait 0.2;

  _id_1EDDEC53ABF6E24C::hoverjet_playflyfx();
  thread _id_18AF78602B67B70C::_id_DC89DF631AF8F890(level._id_1B28B2C12EE9B650, 1);
  thread _id_3BC0D2E90118E128();
  thread _id_F6E1516B5FCBFA29();
  thread _id_DA1C3F385FF2A84C();
  self setvehgoalpos(_id_D0697AF2ECA83D63.origin, 1);
  scripts\engine\utility::waittill_any_timeout_2(20, "goal", "goal_reached");
  thread _id_18AF78602B67B70C::_id_DC89DF631AF8F890(level._id_1B28B2C12EE9B650, 0);
  level notify("flyby_attack_ended");
  self setmaxpitchroll(30, 10);
  self._id_983C6A727F5D4DEF = "waitingtoreturn";
}

_id_62C4D0D07122F07D() {
  level endon("game_ended");
  timelimit = scripts\engine\utility::ter_op(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8(), 10.0, 20);
  starttime = gettime();
  endtime = starttime + timelimit * 1000;

  while(gettime() <= endtime) {
    if(_id_FE88D71CD1669429()) {
      return;
    }
    wait 1;
  }
}

_id_FE88D71CD1669429() {
  foreach(player in level.players) {
    if(!_id_A387A3A903F7DF2D("bunker_trigger", player))
      return 0;
  }

  return 1;
}

_id_A8457407BFDFDA85(waittime) {
  level endon("game_ended");
  wait(waittime);
  level notify("white_phosphorus_end");
}

_id_A32AF97D30DA7AB3(streakinfo) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  self endon("death");
  _id_C12314B8B47F7C35 = scripts\engine\utility::getStruct("harrier_flyby_start", "script_noteworthy").origin + (0, 0, 2000);
  _id_0BEA66D09411DB20 = scripts\engine\utility::getStruct("harrier_flyby_end", "script_noteworthy").origin + (0, 0, 2000);
  flighttime = getdvarint("dvar_22408D61C0C1B0B3", 20);
  _id_924D800BE62C4E51 = _id_C12314B8B47F7C35 + anglesToForward(self.angles) * 1000;
  _id_AAD5BB2395B29D70 = _id_0BEA66D09411DB20 - anglesToForward(self.angles) * 1000;
  _id_C2DEFFE4ABA8FA7C = length(_id_924D800BE62C4E51 - _id_AAD5BB2395B29D70);
  _id_B0E5086E4B02622A = (0, 1000, 0);
  _id_0D2AD83B98DB1ACA = scripts\engine\utility::spawn_tag_origin(_id_C12314B8B47F7C35, self.angles);
  _id_A70E83A7E6D941D5 = scripts\engine\utility::spawn_tag_origin(_id_0BEA66D09411DB20, self.angles);
  _id_32D767AACA8830E6 = scripts\engine\utility::spawn_tag_origin(_id_924D800BE62C4E51, self.angles);
  _id_A2ED028031412FE5 = scripts\engine\utility::spawn_tag_origin(_id_AAD5BB2395B29D70, self.angles);
  _id_0A14BD4FDE7F6316 = scripts\cp\utility::get_point_in_local_ent_space(_id_0D2AD83B98DB1ACA, _id_B0E5086E4B02622A);
  _id_DDB07CC91B9762C9 = scripts\cp\utility::get_point_in_local_ent_space(_id_A70E83A7E6D941D5, _id_B0E5086E4B02622A);
  _id_164F98C748AD0D64 = scripts\cp\utility::get_point_in_local_ent_space(_id_32D767AACA8830E6, _id_B0E5086E4B02622A);
  _id_A772E47FEEC7E2DD = scripts\cp\utility::get_point_in_local_ent_space(_id_A2ED028031412FE5, _id_B0E5086E4B02622A);
  _id_30A3F1579CA0253A = 5;
  thread scripts\cp_mp\killstreaks\white_phosphorus::wp_enterpayloadaudio();
  thread scripts\cp_mp\killstreaks\white_phosphorus::wp_exitpayloadaudio(_id_0BEA66D09411DB20, flighttime);
  _id_E9727E658CA8DFD2 = 3;
  self.owner = self;
  waittillframeend;
  self notify("delivering_wp_payload");
  wp_handlepayloadtyperelease(scripts\cp_mp\killstreaks\white_phosphorus::wp_fireairburst, _id_C12314B8B47F7C35, _id_924D800BE62C4E51, _id_C2DEFFE4ABA8FA7C, _id_30A3F1579CA0253A, 1000, _id_E9727E658CA8DFD2, 1);
  wp_handlepayloadtyperelease(scripts\cp_mp\killstreaks\white_phosphorus::wp_firesmoke, _id_C12314B8B47F7C35, _id_924D800BE62C4E51, _id_C2DEFFE4ABA8FA7C, _id_30A3F1579CA0253A, 1000, 3, 1);
  wp_handlepayloadtyperelease(scripts\cp_mp\killstreaks\white_phosphorus::wp_fireflaregroup, _id_C12314B8B47F7C35, _id_924D800BE62C4E51, _id_C2DEFFE4ABA8FA7C, _id_30A3F1579CA0253A, 1000, 6, 2);
  wp_handlepayloadtyperelease(scripts\cp_mp\killstreaks\white_phosphorus::wp_fireairburst, _id_0A14BD4FDE7F6316, _id_164F98C748AD0D64, _id_C2DEFFE4ABA8FA7C, _id_30A3F1579CA0253A, 1000, _id_E9727E658CA8DFD2, 1);
  wp_handlepayloadtyperelease(scripts\cp_mp\killstreaks\white_phosphorus::wp_firesmoke, _id_0A14BD4FDE7F6316, _id_164F98C748AD0D64, _id_C2DEFFE4ABA8FA7C, _id_30A3F1579CA0253A, 1000, 3, 1);
  wp_handlepayloadtyperelease(scripts\cp_mp\killstreaks\white_phosphorus::wp_fireflaregroup, _id_0A14BD4FDE7F6316, _id_164F98C748AD0D64, _id_C2DEFFE4ABA8FA7C, _id_30A3F1579CA0253A, 1000, 6, 2);
  level thread _id_A8457407BFDFDA85(flighttime * 2);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(flighttime);
  self stopsounds();
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5.33);
}

_id_DA1C3F385FF2A84C() {
  level endon("game_ended");
  _id_AA188171F75C4CD0 = _id_D0CA140D890B1423();

  foreach(ai in _id_AA188171F75C4CD0) {
    ai.ignoreall = 1;
    ai.goalradius = 64;
    ai dodamage(ai.health + 100, ai.origin);
  }
}

wp_handlepayloadtyperelease(_id_FAB341CDE0F5A8A4, _id_3E69F8D86497745D, _id_EC975DF40AFFB201, _id_985ED30DFF21F18C, _id_30A3F1579CA0253A, _id_624C6F581E3A3784, _id_F5C59BE7BAF53B36, _id_3C6798C87677A9C3) {
  _id_BEBE0D78A71DB256 = int(_id_985ED30DFF21F18C / _id_624C6F581E3A3784);
  _id_D0BB190B577957F4 = 0;

  if(!isDefined(_id_F5C59BE7BAF53B36))
    _id_F5C59BE7BAF53B36 = _id_BEBE0D78A71DB256;
  else {
    _id_2DBC68179E13EA9E = _id_BEBE0D78A71DB256 - _id_F5C59BE7BAF53B36;
    _id_D0BB190B577957F4 = int(_id_2DBC68179E13EA9E / 2);
  }

  if(isDefined(_id_3C6798C87677A9C3))
    _id_D0BB190B577957F4 = _id_D0BB190B577957F4 + _id_3C6798C87677A9C3;

  _id_67B9AB39704D906E = anglesToForward(self.angles);
  _id_6622BF241E83CB33 = _id_EC975DF40AFFB201;
  _id_B75CA07CCC1468B5 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_BEBE0D78A71DB256; _id_AC0E594AC96AA3A8++) {
    _id_2BC9225BC1B9C108 = length(_id_3E69F8D86497745D - _id_6622BF241E83CB33);
    _id_B540FEDD1D9812F4 = max(0, _id_2BC9225BC1B9C108 / (self.speed * 1000));

    if(_id_AC0E594AC96AA3A8 < _id_D0BB190B577957F4) {
      _id_6622BF241E83CB33 = _id_6622BF241E83CB33 + _id_67B9AB39704D906E * _id_624C6F581E3A3784;
      continue;
    }

    _id_5E4B11A3DBE28124 = _id_6622BF241E83CB33 - (0, 0, 2000);

    if(_id_FAB341CDE0F5A8A4 == scripts\cp_mp\killstreaks\white_phosphorus::wp_firesmoke)
      self thread[[_id_FAB341CDE0F5A8A4]](_id_5E4B11A3DBE28124, _id_67B9AB39704D906E, _id_B540FEDD1D9812F4, _id_AC0E594AC96AA3A8);
    else
      self thread[[_id_FAB341CDE0F5A8A4]](_id_5E4B11A3DBE28124, _id_67B9AB39704D906E, _id_B540FEDD1D9812F4);

    _id_6622BF241E83CB33 = _id_6622BF241E83CB33 + _id_67B9AB39704D906E * _id_624C6F581E3A3784;
    _id_B75CA07CCC1468B5++;

    if(_id_B75CA07CCC1468B5 == _id_F5C59BE7BAF53B36) {
      break;
    }
  }
}

_id_F92431F823F09E69() {
  self endon("death");
  level endon("game_ended");
  self endon("entered_daze_phase");
  self endon("entered_death_sequence");
  startstruct = scripts\engine\utility::getStruct("harrier_flyby_start", "script_noteworthy");
  _id_FE68C088C14EF3D6 = scripts\engine\utility::getStruct("harrier_return_spot_1", "script_noteworthy");
  _id_FE68BF88C14EF1A3 = scripts\engine\utility::getStruct("harrier_return_spot_2", "script_noteworthy");
  self sethoverparams(250, 100, 100);
  self setlookatent(startstruct._id_9BC5CB3240D03C4C);
  wait 6;
  self vehicle_setspeed(100, 100, 150);
  self setvehgoalpos(_id_FE68C088C14EF3D6.origin, 1);
  scripts\engine\utility::waittill_any_timeout_2(20, "goal", "goal_reached");
  wait 0.5;
  self notify("flyby_attack_done");
  self vehicle_setspeed(10, 50, 50);
  wait 1;
  self setvehgoalpos(_id_FE68BF88C14EF1A3.origin, 1);
  scripts\engine\utility::waittill_any_timeout_2(20, "goal", "goal_reached");
  self clearlookatent();
  self._id_983C6A727F5D4DEF = "idle";
}

_id_F097ABDCD3422D59(_id_28F8F60414DFB888) {
  self endon("death");
  level endon("game_ended");
  _id_28F8F60414DFB888 endon("entered_daze_phase");
  _id_28F8F60414DFB888 endon("entered_death_sequence");

  foreach(turret in _id_28F8F60414DFB888.turrets)
  turret settargetentity(_id_28F8F60414DFB888._id_6B70F24512689931, (0, 0, 0));

  _id_FA2483033790AF38 = makeweapon("hover_jet_turret_cp");
  _id_2C90EA28723E0BF7 = weaponfiretime(_id_FA2483033790AF38);

  while(_id_37B1257733BFF5B9() == "flybyattack") {
    foreach(turret in _id_28F8F60414DFB888.turrets)
    turret shootturret();

    wait(_id_2C90EA28723E0BF7);
  }
}

_id_F6E1516B5FCBFA29() {
  self endon("death");
  level endon("game_ended");
  self endon("entered_daze_phase");
  self endon("entered_death_sequence");

  while(_id_37B1257733BFF5B9() == "flybyattack") {
    players = level.players;

    foreach(player in players) {
      if(_id_49E451851E0C9C17(player)) {
        player dodamage(200, self.origin, self, self.turrets[0], "MOD_PROJECTILE");
        continue;
      }

      player visionsetnakedforplayer("", 0.0);
    }

    wait 0.2;
  }
}

_id_3BC0D2E90118E128() {
  level endon("game_ended");
  self endon("death");
  players = level.players;

  foreach(player in players)
  level thread _id_019463432FAC7B25(player);
}

_id_019463432FAC7B25(player) {
  level endon("game_ended");
  player endon("death");
  player endon("disconnect");
  player._id_B2E7E41C5DF2102B = 0;
  player visionsetnakedforplayer("", 0.0);

  while(_id_37B1257733BFF5B9() == "flybyattack") {
    if(istrue(player._id_B2E7E41C5DF2102B)) {
      if(!_id_49E451851E0C9C17(player)) {
        player._id_B2E7E41C5DF2102B = 0;
        stopFXOnTag(level._effect["vfx_gas_ring_player"], player, "tag_eye");
        player visionsetnakedforplayer("", 0.0);
      }
    } else if(_id_49E451851E0C9C17(player)) {
      player._id_B2E7E41C5DF2102B = 1;
      playFXOnTag(level._effect["vfx_gas_ring_player"], player, "tag_eye");
      player visionsetnakedforplayer("hometown_gas_close_less", 0.2);
    }

    wait 0.3;
  }

  player._id_B2E7E41C5DF2102B = undefined;
  stopFXOnTag(level._effect["vfx_gas_ring_player"], player, "tag_eye");
  player visionsetnakedforplayer("", 0.0);
}

_id_F35FE771692546B9() {
  _id_01E2777328B6B536 = scripts\engine\utility::getStruct("harrier_return_spot_2", "script_noteworthy");
  startpoint = scripts\engine\utility::getStruct("harrier_flyby_start", "script_noteworthy");
  _id_61DD90FF44CE35DA = level._id_B3826A903E994BA3;
  _id_09FDBBAF3C134BD5 = distance2d(_id_61DD90FF44CE35DA.origin, startpoint.origin);
  _id_C89123F941C94F8D = distance2d(_id_01E2777328B6B536.origin, startpoint.origin);
  return _id_C89123F941C94F8D < _id_09FDBBAF3C134BD5;
}

_id_49E451851E0C9C17(player) {
  if(!isalive(player) || _id_A387A3A903F7DF2D("bunker_trigger", player))
    return 0;
  else
    return 1;
}

_id_C4290C38B7A644B6() {
  foreach(player in level.players) {
    if(isplayeronground(player))
      return 1;
  }

  return 0;
}

isplayeronground(player) {
  if(!isalive(player) || _id_A387A3A903F7DF2D("gauntlet_trigger", player) || _id_A387A3A903F7DF2D("bunker_trigger", player) || _id_A387A3A903F7DF2D("low_ledge_trigger", player))
    return 0;
  else
    return 1;
}

_id_106E32A37C0137D4(trigger) {
  foreach(player in level.players) {
    if(isalive(player) && player istouching(trigger))
      return 0;
  }

  return 1;
}

_id_A387A3A903F7DF2D(_id_92C4DE821390F609, player) {
  volumes = getEntArray(_id_92C4DE821390F609, "script_noteworthy");

  foreach(vol in volumes) {
    if(player istouching(vol))
      return 1;
  }

  return 0;
}

_id_EF673652753B9FCF() {
  level endon("game_ended");
  level endon("vtol_destroyed");
  wait 3;
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_HARRIER_BOSS/INTRODUCE_ENRAGE", "allies", 5);
  remainingtime = getdvarint("dvar_A03AEDBB07BE1323", 0) * 60;

  while(remainingtime > 0) {
    remainingtime--;

    if(remainingtime == 120)
      scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_HARRIER_BOSS/2_MINUTES_LEFT");

    if(remainingtime == 60)
      scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_HARRIER_BOSS/1_MINUTE_LEFT");

    wait 1;
  }

  wait 1;
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_HARRIER_BOSS/ENRAGE_DONE", "allies", 5);
  wait 3;
  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

_id_5E0F7D6E1DF0562A() {
  level endon("game_ended");
  button = _id_18AF78602B67B70C::_id_050326CC21187D35("bunker_power_button", &"CP_HARRIER_BOSS/POWER_ON", "electrical_box_small_02");
  button _meth_DFB78B3E724AD620(1);
  head_icon = createheadicon(button);
  setheadiconimage(head_icon, "hud_icon_head_equipment_friendly");
  setheadiconmaxdistance(head_icon, 1024);

  foreach(player in level.players)
  addclienttoheadiconmask(head_icon, player);

  showheadicontoplayersinmask(head_icon);

  for(;;) {
    button waittill("trigger", player);

    if(!isPlayer(player)) {
      waitframe();
      continue;
    }

    button _meth_DFB78B3E724AD620(0);
    level notify("gauntlet_power_on");
    level._id_B8D89A9EA2DD2F3B = 1;

    foreach(player in level.players)
    player thread _id_721F01B9DF408A53(&"CP_HARRIER_BOSS/POWER_IS_ON");

    break;
  }

  deleteheadicon(head_icon);
}

_id_1C20DB623BDAC8A3(_id_42044BD42909B8CF) {
  _id_057FB4254BF14310 = _id_27164089FC92B135("elevator_cart_1a");
  _id_057FB7254BF149A9 = _id_27164089FC92B135("elevator_cart_1b");
  _id_0572C4254BE351BB = _id_27164089FC92B135("elevator_cart_2a");
  _id_0572C5254BE353EE = _id_27164089FC92B135("elevator_cart_2b");
  _id_0576A8254BE709FE = _id_27164089FC92B135("elevator_cart_3a");
  _id_0576A7254BE707CB = _id_27164089FC92B135("elevator_cart_3b");
  _id_058CA8254BFF3D31 = _id_27164089FC92B135("elevator_cart_4a");
  _id_058CA5254BFF3698 = _id_27164089FC92B135("elevator_cart_4b");
  _id_FA47ED831976F767 = getdvarint("dvar_0536F2F083864ED5", 6);
  _id_8E0250F37ECA3ACA = getdvarint("dvar_7A56828549F6CBCC", 6);
  _id_34BC338C00C37279 = getdvarint("dvar_6698EFDF8B143443", 6);
  _id_6027419DA77B5724 = getdvarint("dvar_1D4B51070CC2EC52", 6);

  if(getdvarint("dvar_11BE6949839DA46A", 0) > 0) {
    level thread _id_B6EBC4E188D6824B(_id_057FB4254BF14310, _id_057FB7254BF149A9, _id_FA47ED831976F767, 3, "lift1_lowmark", "lift1_highmark", undefined, _id_42044BD42909B8CF);
    level thread _id_B6EBC4E188D6824B(_id_0572C5254BE353EE, _id_0572C4254BE351BB, _id_8E0250F37ECA3ACA, 3, "lift2_lowmark", "lift2_highmark", undefined, _id_42044BD42909B8CF);
    level thread _id_B6EBC4E188D6824B(_id_0576A7254BE707CB, _id_0576A8254BE709FE, _id_34BC338C00C37279, 3, "lift3_lowmark", "lift3_highmark", undefined, _id_42044BD42909B8CF);
    level thread _id_B6EBC4E188D6824B(_id_058CA5254BFF3698, _id_058CA8254BFF3D31, _id_6027419DA77B5724, 3, "lift4_lowmark", "lift4_highmark", undefined, _id_42044BD42909B8CF);
  } else {
    _id_E6FF7DC9A1F38A2D = "";

    if(getdvarint("dvar_06E2A053DB7CD02A", 0) > 0)
      _id_E6FF7DC9A1F38A2D = "_B";

    _id_F60F53F75958341C = _id_18AF78602B67B70C::_id_050326CC21187D35("lift1_button" + _id_E6FF7DC9A1F38A2D, &"CP_HARRIER_BOSS/LIFT_BUTTON", "button_on", "duration_none");
    _id_F60F56F759583AB5 = _id_18AF78602B67B70C::_id_050326CC21187D35("lift2_button" + _id_E6FF7DC9A1F38A2D, &"CP_HARRIER_BOSS/LIFT_BUTTON", "button_on", "duration_none");
    _id_F60F55F759583882 = _id_18AF78602B67B70C::_id_050326CC21187D35("lift3_button" + _id_E6FF7DC9A1F38A2D, &"CP_HARRIER_BOSS/LIFT_BUTTON", "button_on", "duration_none");
    _id_F60F50F759582D83 = _id_18AF78602B67B70C::_id_050326CC21187D35("lift4_button" + _id_E6FF7DC9A1F38A2D, &"CP_HARRIER_BOSS/LIFT_BUTTON", "button_on", "duration_none");
    level thread _id_B6EBC4E188D6824B(_id_057FB4254BF14310, _id_057FB7254BF149A9, _id_FA47ED831976F767, 3, "lift1_lowmark", "lift1_highmark", [_id_F60F53F75958341C], _id_42044BD42909B8CF);
    level thread _id_B6EBC4E188D6824B(_id_0572C4254BE351BB, _id_0572C5254BE353EE, _id_8E0250F37ECA3ACA, 3, "lift2_lowmark", "lift2_highmark", [_id_F60F56F759583AB5], _id_42044BD42909B8CF);
    level thread _id_B6EBC4E188D6824B(_id_0576A7254BE707CB, _id_0576A8254BE709FE, _id_34BC338C00C37279, 3, "lift3_lowmark", "lift3_highmark", [_id_F60F55F759583882], _id_42044BD42909B8CF);
    level thread _id_B6EBC4E188D6824B(_id_058CA5254BFF3698, _id_058CA8254BFF3D31, _id_6027419DA77B5724, 3, "lift4_lowmark", "lift4_highmark", [_id_F60F50F759582D83], _id_42044BD42909B8CF);
  }
}

_id_27164089FC92B135(_id_92C4DE821390F609) {
  _id_222BBC8DE3DC3237 = getEntArray(_id_92C4DE821390F609, "script_noteworthy");
  _id_B00C4E905E76C87A = _id_222BBC8DE3DC3237[0];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_222BBC8DE3DC3237.size; _id_AC0E594AC96AA3A8++)
    _id_222BBC8DE3DC3237[_id_AC0E594AC96AA3A8] linkTo(_id_B00C4E905E76C87A);

  _id_67F14F8315CB0F2F = strtok(_id_92C4DE821390F609, "_");
  _id_EC563CFBB6350492 = getEnt("lift_trigger_" + _id_67F14F8315CB0F2F[_id_67F14F8315CB0F2F.size - 1], "script_noteworthy");

  if(isDefined(_id_EC563CFBB6350492))
    _id_B00C4E905E76C87A._id_EC563CFBB6350492 = _id_EC563CFBB6350492;

  _id_B00C4E905E76C87A.soundent = spawn("script_model", _id_B00C4E905E76C87A.origin);
  _id_B00C4E905E76C87A.soundent setModel("tag_origin");
  _id_B00C4E905E76C87A.soundent linkTo(_id_B00C4E905E76C87A);
  return _id_B00C4E905E76C87A;
}

_id_0F48B933AFFEF552() {
  level endon("game_ended");

  foreach(player in level.players) {
    if(player istouching(self)) {
      _id_815D30728A6EF9D9 = scripts\engine\utility::getclosest(player.origin, scripts\engine\utility::getStructArray("lift_trapped_teleport", "script_noteworthy"));
      player setOrigin(_id_815D30728A6EF9D9.origin);
    }
  }
}

_id_B6EBC4E188D6824B(_id_A711587F96D6B5F9, _id_79CD847C1BF33E04, _id_1D9A4729A1DE52F0, _id_A43BF672B2E17585, _id_516807205A2E442D, _id_975676FB871A2301, _id_1AF980F72D516C94, _id_42044BD42909B8CF) {
  level endon("game_ended");
  _id_F7F117B99ADCD32C = scripts\engine\utility::getStruct(_id_975676FB871A2301, "script_noteworthy");
  _id_7C88A5C1980A7558 = scripts\engine\utility::getStruct(_id_516807205A2E442D, "script_noteworthy");
  _id_A711587F96D6B5F9._id_6B7F7DC18AA04441 = _id_7C88A5C1980A7558.origin;
  _id_A711587F96D6B5F9._id_E72EEFB98DC16485 = (_id_7C88A5C1980A7558.origin[0], _id_7C88A5C1980A7558.origin[1], _id_F7F117B99ADCD32C.origin[2]);
  _id_79CD847C1BF33E04._id_E72EEFB98DC16485 = _id_F7F117B99ADCD32C.origin;
  _id_79CD847C1BF33E04._id_6B7F7DC18AA04441 = (_id_F7F117B99ADCD32C.origin[0], _id_F7F117B99ADCD32C.origin[1], _id_7C88A5C1980A7558.origin[2]);
  _id_506EE998058572B0 = undefined;
  _id_D777457DC762CDBD = _id_1AF980F72D516C94[0].script_noteworthy + "_pressed";
  level thread _id_3E32E3409D4BF4DE(_id_1AF980F72D516C94, _id_D777457DC762CDBD);

  for(;;) {
    if(isDefined(_id_1AF980F72D516C94)) {
      level waittill(_id_D777457DC762CDBD, player);

      if(!isPlayer(player)) {
        continue;
      }
      foreach(button in _id_1AF980F72D516C94)
      button _meth_DFB78B3E724AD620(0);

      if(istrue(_id_42044BD42909B8CF) && !istrue(level._id_B8D89A9EA2DD2F3B)) {
        player _id_721F01B9DF408A53(&"CP_HARRIER_BOSS/NEED_POWER");
        wait 1;

        foreach(button in _id_1AF980F72D516C94)
        button _meth_DFB78B3E724AD620(1);

        continue;
      }
    }

    _id_A711587F96D6B5F9.soundent playSound("scn_cp_elevator_in_use_start");
    _id_79CD847C1BF33E04.soundent playSound("scn_cp_elevator_in_use_start");
    _id_A711587F96D6B5F9.soundent playLoopSound("scn_cp_elevator_in_use_lp");
    _id_79CD847C1BF33E04.soundent playLoopSound("scn_cp_elevator_in_use_lp");
    _id_A711587F96D6B5F9 moveTo(_id_A711587F96D6B5F9._id_E72EEFB98DC16485, _id_1D9A4729A1DE52F0, 0.5, 0.5);
    _id_79CD847C1BF33E04 moveTo(_id_79CD847C1BF33E04._id_6B7F7DC18AA04441, _id_1D9A4729A1DE52F0, 0.5, 0.5);
    wait(_id_1D9A4729A1DE52F0 + _id_A43BF672B2E17585);
    _id_A711587F96D6B5F9.soundent playSound("scn_cp_elevator_in_use_stop");
    _id_79CD847C1BF33E04.soundent playSound("scn_cp_elevator_in_use_stop");
    _id_A711587F96D6B5F9.soundent stoploopsound();
    _id_79CD847C1BF33E04.soundent stoploopsound();
    _id_506EE998058572B0 = _id_A711587F96D6B5F9;
    _id_A711587F96D6B5F9 = _id_79CD847C1BF33E04;
    _id_79CD847C1BF33E04 = _id_506EE998058572B0;

    if(isDefined(_id_A711587F96D6B5F9._id_EC563CFBB6350492))
      _id_A711587F96D6B5F9._id_EC563CFBB6350492 _id_0F48B933AFFEF552();

    if(isDefined(_id_1AF980F72D516C94)) {
      foreach(button in _id_1AF980F72D516C94)
      button _meth_DFB78B3E724AD620(1);
    }
  }
}

_id_3E32E3409D4BF4DE(buttons, notifystring) {
  level endon("game_ended");

  foreach(button in buttons)
  button thread _id_883F0188DC82B5AD(button, notifystring);
}

_id_883F0188DC82B5AD(button, notifystring) {
  level endon("game_ended");

  for(;;) {
    button waittill("trigger", player);

    if(isPlayer(player)) {
      button playSound("scn_cp_elevator_button_press");
      level notify(notifystring, player);
    }

    waitframe();
    waitframe();
  }
}

_id_FB95CF354CF9E68E() {
  wait 5;
  struct = scripts\engine\utility::getStruct("test_loadout", "script_noteworthy");
  thread edit_loadout_think(struct);
}

edit_loadout_think(struct) {
  level endon("game_ended");
  model = spawn("script_model", struct.origin);
  model setModel("tag_origin");
  model scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_HARRIER_BOSS/TESTLOADOUT", 25, "duration_short", "hide", 256, 65, 64, 65);
  model.headicon = createheadicon(model);
  setheadiconimage(model.headicon, "hud_icon_survival_weapon");
  setheadiconsnaptoedges(model.headicon, 0);
  setheadiconmaxdistance(model.headicon, 1024);
  setheadiconnaturaldistance(model.headicon, 30);
  setheadiconzoffset(model.headicon, 10);

  for(;;) {
    model waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    player thread edit_loadout(model);
  }
}

edit_loadout(interaction) {
  self endon("disconnect");
  self endon("last_stand");
  level endon("game_ended");
  interaction disableplayeruse(self);
  self setclientomnvar("cp_open_cac", -1);
  self setclientomnvar("ui_options_menu", 2);
  scripts\engine\utility::waittill_any_two("loadout_given", "loadout_menu_closed");
  wait 1;
  self setclientomnvar("cp_open_cac", -2);
  interaction enableplayeruse(self);
}

_id_1BD1AB149E9DBA98() {
  _id_32D50387E3E59250 = scripts\engine\utility::getStructArray("parachute_interact", "script_noteworthy");

  foreach(struct in _id_32D50387E3E59250) {
    button = _id_18AF78602B67B70C::_id_683F024F53CEE760(struct, &"CP_HARRIER_BOSS/PICKUP_PARACHUTE", "parts_parachute_pack_mp");
    button sethintdisplayrange(512);
    button sethintdisplayfov(200);
    button setuserange(100);
    button setusefov(180);
    button thread _id_CAA6B2354C5F6312();
  }
}

_id_CAA6B2354C5F6312() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player) || istrue(player._id_2D1F8B5D21B0710A)) {
      continue;
    }
    self _meth_DFB78B3E724AD620(0);
    _id_375400F1A557A500(player);
    self delete();
  }
}

_id_E70862ADB7DAE459() {
  scripts\cp\cp_objectives::registerobjective("pipe_room", ::_id_8D2BD4145032E443, ::_id_F23258E8318873D1, ::_id_9910413691E0DB02, scripts\cp\cp_objectives::debugbeatobjective, undefined);
  scripts\cp\cp_objectives::registerobjective("get_to_roof", ::_id_8D2BD4145032E443, ::_id_B94D2F638C99CE01, ::_id_441C6F583339AA06, scripts\cp\cp_objectives::debugbeatobjective, undefined);
  scripts\cp\cp_objectives::registerobjective("kill_harrier", ::_id_8D2BD4145032E443, ::_id_B381CA59743B01EB, ::_id_441C6F583339AA06, scripts\cp\cp_objectives::debugbeatobjective, undefined);
}

_id_333AB9FC48A63426(button) {
  level endon("game_ended");

  for(;;) {
    button waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    button _meth_DFB78B3E724AD620(0);

    if(getdvarint("dvar_38934EF98DE660BF", 0) == 0)
      _id_92720692FFB59573();

    return;
  }
}

_id_2B93197B263D2490() {
  _id_9B89BBAFD117F579 = scripts\engine\utility::getStructArray("default_player_start", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    level.players[_id_AC0E594AC96AA3A8] setOrigin(_id_9B89BBAFD117F579[_id_AC0E594AC96AA3A8].origin);
    level.players[_id_AC0E594AC96AA3A8] setplayerangles(scripts\engine\utility::ter_op(isDefined(_id_9B89BBAFD117F579[_id_AC0E594AC96AA3A8].angles), _id_9B89BBAFD117F579[_id_AC0E594AC96AA3A8].angles, (0, 0, 0)));
  }
}

_id_8D2BD4145032E443(objectivestruct) {}

_id_441C6F583339AA06(objectivestruct) {}

_id_F23258E8318873D1(objectivestruct) {
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("Raid: Pipe Room");
  wait 1;
  level._id_AD9B99883D277045 = "pipe_room";
  scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_pipe_room");
  _id_25700879EDC2479A();
  _id_2E3C207F7651DDEC::_id_6BFBC5BA110A8CF6();
  level waittill("pipe_room_done");
  scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid: Pipe Room");
  wait 0.5;
}

_id_9910413691E0DB02(objectivestruct) {
  wait 1;
  _id_2B93197B263D2490();
  waitframe();
  _id_2E3C207F7651DDEC::_id_6F04CAF5FBA8EEC2();
}

_id_B94D2F638C99CE01(objectivestruct) {
  level._id_AD9B99883D277045 = "gauntlet_approach";
  scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_gauntlet_approach");
  thread _id_C75C245DCA22D0EC();
  button = _id_18AF78602B67B70C::_id_050326CC21187D35("exfil_button", &"CP_HARRIER_BOSS/EXFIL_BUTTON", "equipment_military_radio_old_01");
  level thread _id_333AB9FC48A63426(button);
  level waittill("harrier_boss_spawned");
  wait 2;
}

_id_B381CA59743B01EB(objectivestruct) {
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("Raid: Harrier");
  level._id_AD9B99883D277045 = "vtol_fight";
  scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_vtol_spawned");

  foreach(player in level.players)
  thread _id_375400F1A557A500(player);

  scripts\engine\utility::flag_set("samsite_activated");
  thread _id_C75C245DCA22D0EC(1);
  _id_DC205A6A9BC12C6D = getEnt("samsite_door", "script_noteworthy");
  _id_DC205A6A9BC12C6D hide();
  _id_DC205A6A9BC12C6D connectpaths();

  if(isDefined(objectivestruct.timer1)) {
    level thread _id_9533F154F400B0B8(objectivestruct.timer1);
    thread scripts\cp\cp_objectives::_id_74E8374F8DD7BEB3(objectivestruct.timer1, objectivestruct.timer2, objectivestruct.timer3);
  }

  level waittill("vtol_destroyed");
  scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid: Harrier");
  wait 2;
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

_id_9533F154F400B0B8(totaltime) {
  level endon("game_ended");
  level endon("kill_harrier_completed");
  level endon("vtol_destroyed");
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_HARRIER_BOSS/INTRODUCE_ENRAGE", "allies", 5);
  remainingtime = totaltime;

  while(remainingtime > 0) {
    remainingtime--;

    if(remainingtime == 120) {
      scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_HARRIER_BOSS/2_MINUTES_LEFT");
      level thread _id_18AF78602B67B70C::_id_775CD164C569E279("dx_guid0ef78c2bd7d54f52a83cd8169a624e6f");
    }

    if(remainingtime == 60) {
      scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_HARRIER_BOSS/1_MINUTE_LEFT");
      level thread _id_18AF78602B67B70C::_id_775CD164C569E279("dx_guid17ea872e46a84bae8aeaf9da7caf7da3");
    }

    wait 1;
  }

  wait 1;
  level thread _id_18AF78602B67B70C::_id_775CD164C569E279("dx_guid85931edd22354fb6b7681a96070afef8");
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_HARRIER_BOSS/ENRAGE_DONE", "allies", 5);
  wait 3;
  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

_id_8C07085249C042C3() {
  level endon("game_ended");

  for(;;) {
    _id_18AF78602B67B70C::_id_6AE8E5D7C480EF7D();
    wait 5;
  }
}

_id_3C720C0157472678() {
  level endon("game_ended");

  for(;;) {
    _id_72DAC79A97FC7C5C = scripts\engine\utility::getStruct("heli_infils_roof_1", "script_noteworthy");
    spawners = scripts\engine\utility::getStructArray("heli_squad_roof_1", "targetname");
    level thread scripts\cp\cp_spawning_util::_id_94E3A9862B435632(_id_72DAC79A97FC7C5C, spawners);
    level waittill("loaded_ai_in_vehicle", vehicle);

    if(isDefined(vehicle)) {
      foreach(rider in vehicle.riders)
      rider thread _id_B30244EF9B2F5F28();
    }

    wait 30;
  }
}

_id_B30244EF9B2F5F28() {
  level endon("game_ended");
  self endon("death");

  while(self islinked())
    wait 1;

  wait 1;
  self.goalradius = 600;
  _id_137CC0FFDF383E20 = scripts\engine\utility::getclosest(self.origin, level.players);
  self setgoalentity(_id_137CC0FFDF383E20);
}

_id_679C2DA1C83EDB81() {
  _id_EC535F0E276A2782 = scripts\engine\utility::getStruct("gasvfx_lowerleft", "script_noteworthy");
  _id_3E3E3A891D46A7EE = scripts\engine\utility::getStruct("gasvfx_upperright", "script_noteworthy");
  level._id_1B28B2C12EE9B650 = _id_18AF78602B67B70C::_id_8D22FF3DA7E116C2(_id_EC535F0E276A2782.origin, _id_3E3E3A891D46A7EE.origin, 500);
}