/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5b3c060b476939a8.gsc
***********************************************/

_id_234851F94416F178() {
  if(!isDefined(level._id_F6BAD8618358A031))
    level._id_F6BAD8618358A031 = spawnStruct();

  level._id_F6BAD8618358A031._id_3D605BC71C5D48E3 = "iw9_oxygenmask";
  scripts\cp_mp\utility\script_utility::registersharedfunc("oxygenmask", "onGive", ::_id_78936156143BF6FA);
  scripts\cp_mp\utility\script_utility::registersharedfunc("oxygenmask", "onEquip", ::_id_5320A46C0E139CB5);
  scripts\cp_mp\utility\script_utility::registersharedfunc("oxygenmask", "onUse", ::_id_C6F7C3926E6E4522);
  scripts\cp_mp\utility\script_utility::registersharedfunc("oxygenmask", "onUseComplete", ::_id_CAD73059BABFBE29);
  scripts\cp_mp\utility\script_utility::registersharedfunc("oxygenmask", "onRemove", ::_id_FE80C78BD0D58EBF);
  scripts\cp_mp\utility\script_utility::registersharedfunc("oxygenmask", "onUnusable", ::_id_AFB7A317198D0688);
}

_id_67939C281EB5C262() {
  return 1.0;
}

_id_18DFEA62F135DEF6(origin, angles, _id_FC1437797F3ADF22) {
  _id_5BF3E22BDB650432 = scripts\engine\utility::drop_to_ground(origin, 25, -50) + (0, 0, 6);
  _id_F9760660B9B4B1A7 = spawn("script_model", _id_5BF3E22BDB650432);
  _id_F9760660B9B4B1A7.angles = angles;
  _id_F9760660B9B4B1A7 setModel("misc_wm_oxygen_tank_v0");
  _id_F9760660B9B4B1A7.targetname = "oxygenmask_usable";

  if(istrue(_id_FC1437797F3ADF22)) {
    icon = "hud_icon_equipment_oxygen";
    _id_F9760660B9B4B1A7._id_461D51A679E3530D = _id_F9760660B9B4B1A7 scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players, icon, 16, 0, 512, 100, 0, 0, 1, undefined, 1);
  }

  _id_F9760660B9B4B1A7 thread _id_DC08EFAC4AA8BC95();
  return _id_F9760660B9B4B1A7;
}

_id_8FC85383E9F1B6E6() {
  if(istrue(self._id_23A6763562820C70)) {
    if(soundexists("cp_oxygenmask_hiss"))
      playsoundatpos(self.origin, "cp_oxygenmask_hiss");

    thread _id_1B4114093CD44368::_id_A51CB31233EACF9E();

    if(isDefined(self._id_72F72F6558F6A22A))
      self._id_72F72F6558F6A22A delete();

    return 1;
  }

  return 0;
}

_id_DC08EFAC4AA8BC95(owner) {
  self endon("death");

  if(!istrue(self._id_0E1D86A45DF92D80)) {
    self._id_0E1D86A45DF92D80 = 1;
    self makeusable();
  } else
    self _meth_DFB78B3E724AD620(1);

  self.hintstring = &"LUA_MENU_CP/SUPER_OXYGENMASK";
  self._id_3C8F4CDAD0503A27 = &"LUA_MENU_CP/SUPER_OXYGENMASK_IN_USE";
  self setCursorHint("HINT_BUTTON");
  self sethintdisplayfov(200);
  self setuserange(150);
  self setusefov(190);
  self sethintonobstruction("show");
  self setuseholdduration("duration_short");
  self setHintString(self.hintstring);
  self setuseprioritymax();

  if(isDefined(owner)) {
    self sethintdisplayrange(220);

    foreach(_id_5ECABDFE40A96663 in level.players) {
      if(_id_5ECABDFE40A96663 == owner) {
        self disableplayeruse(_id_5ECABDFE40A96663);
        continue;
      }

      self enableplayeruse(_id_5ECABDFE40A96663);
    }
  } else
    self sethintdisplayrange(620);

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(player)) {
      if(!player scripts\cp\utility::is_valid_player()) {
        continue;
      }
      if(istrue(player._id_23A6763562820C70)) {
        continue;
      }
      if(istrue(player.super_activated)) {
        continue;
      }
      if(istrue(self._id_2EF06340D91524CC)) {
        continue;
      }
      if(!istrue(_id_B42B8567448E204A(player getEye(), self.origin, self))) {
        continue;
      }
      if(isDefined(owner)) {
        if(owner == player) {
          continue;
        }
        if(istrue(owner._id_A3BDE3B734D04764)) {
          continue;
        }
        if(!owner scripts\cp\utility::is_valid_player())
          continue;
      }

      self _meth_DFB78B3E724AD620(1);
      player playlocalsound("cp_generic_pickup_small");
      level notify("player_given_oxygenmask", player);

      if(isDefined(self._id_461D51A679E3530D)) {
        scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self._id_461D51A679E3530D);
        self._id_461D51A679E3530D = undefined;
      }

      player _id_1B4114093CD44368::_id_24A2E2FA6ADC7F55();

      if(isDefined(owner))
        owner thread _id_1B4114093CD44368::_id_A51CB31233EACF9E();

      self delete();
    }
  }
}

_id_33FCE193BE4821AA() {
  _id_F9760660B9B4B1A7 = spawn("script_model", self.origin);
  _id_F9760660B9B4B1A7.angles = self.angles;
  _id_F9760660B9B4B1A7 setModel("tag_origin");
  _id_F9760660B9B4B1A7.targetname = "oxygenmask_usable_player";
  _id_F9760660B9B4B1A7 linkTo(self, "j_spine4", (0, 0, 0), (0, 0, 0));
  self._id_72F72F6558F6A22A = _id_F9760660B9B4B1A7;
  _id_F9760660B9B4B1A7.owner = self;
  _id_F9760660B9B4B1A7 thread _id_DC08EFAC4AA8BC95(self);
}

_id_18DD74772EE0D1FD(_id_41D8BF229CF29051) {
  if(isDefined(self._id_72F72F6558F6A22A)) {
    if(istrue(_id_41D8BF229CF29051)) {
      _id_12B8B74410667A1A = self._id_72F72F6558F6A22A;
      _id_12B8B74410667A1A setHintString(_id_12B8B74410667A1A.hintstring);
      _id_12B8B74410667A1A setuseholdduration("duration_short");
      _id_12B8B74410667A1A._id_2EF06340D91524CC = undefined;
      _id_12B8B74410667A1A _meth_DFB78B3E724AD620(1);
    } else {
      _id_12B8B74410667A1A = self._id_72F72F6558F6A22A;
      _id_12B8B74410667A1A setHintString(_id_12B8B74410667A1A._id_3C8F4CDAD0503A27);
      _id_12B8B74410667A1A setuseholdduration("duration_none");
      _id_12B8B74410667A1A._id_2EF06340D91524CC = 1;
      _id_12B8B74410667A1A _meth_DFB78B3E724AD620(1);
    }
  }
}

_id_2C9C3BC278844056() {}

_id_2A830025D8B846F3() {
  for(;;) {
    self setweaponammoclip(level._id_F6BAD8618358A031._id_3D605BC71C5D48E3, 99);
    wait 10;
  }
}

_id_4D3FA9BAF4CE4BFB() {
  currentweapon = self getcurrentweapon();

  if(!isDefined(currentweapon) || currentweapon.basename == "none")
    currentweapon = makeweapon(level._id_F6BAD8618358A031._id_3D605BC71C5D48E3);

  if(currentweapon.basename == "iw9_lm_dblmg2_cp")
    scripts\cp_mp\utility\inventory_utility::_takeweapon(makeweapon(level._id_F6BAD8618358A031._id_3D605BC71C5D48E3));
  else {
    _id_8BB5AE39FAC9A4D2 = scripts\engine\utility::array_combine(self.weaponlist, [self getcurrentweapon()]);

    foreach(weapon in _id_8BB5AE39FAC9A4D2) {
      if(weapon.basename == level._id_F6BAD8618358A031._id_3D605BC71C5D48E3)
        scripts\cp_mp\utility\inventory_utility::_takeweapon(weapon);
    }
  }

  if(isDefined(self._id_9A46747153A02D2F)) {
    if(isweapon(self._id_9A46747153A02D2F)) {
      self.lastdroppableweaponobj = self._id_9A46747153A02D2F;
      self switchtoweaponimmediate(self._id_9A46747153A02D2F);
    } else if(isstring(self._id_9A46747153A02D2F)) {
      _id_A7408DBFED49F3F9 = makeweapon(self._id_9A46747153A02D2F);
      self.lastdroppableweaponobj = _id_A7408DBFED49F3F9;
      self switchtoweaponimmediate(_id_A7408DBFED49F3F9);
    }
  }
}

_id_3EA64F6CDEA1D51B() {
  if(!_id_1B4114093CD44368::_id_23A6763562820C70()) {
    return;
  }
  self._id_72F72F6558F6A22A delete();
  thread _id_1B4114093CD44368::_id_A51CB31233EACF9E();
  _id_18DFEA62F135DEF6(self.origin, self.angles, 1);
}

_id_9154DA52B1732C46() {
  self notify("new_oxygenmask_ui");
  self endon("new_oxygenmask_ui");
  scripts\cp\utility::_id_C2963CDB537E31A0();

  for(;;) {
    if(self._id_FE2B9EE0479AD3CF == "Ready")
      scripts\cp\utility::hint_prompt("oxygentank_ready", 1, undefined, 1);
    else
      scripts\cp\utility::_id_C2963CDB537E31A0();

    self waittill("oxygenmask_changestate");
  }
}

_id_39DBD79F6E9CD21B() {
  scripts\cp\utility::_id_C2963CDB537E31A0();
}

_id_64A40FAF54EFBDB0() {
  icon = "hud_icon_equipment_oxygen";
  offset = 16;
  _id_B9352C16DBBDC298 = 1;
  _id_1E440F4549D5E518 = [];

  if(level.players.size == 1) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(level.players[_id_AC0E594AC96AA3A8] != self)
      _id_1E440F4549D5E518[_id_1E440F4549D5E518.size] = level.players[_id_AC0E594AC96AA3A8];
  }

  self._id_0AFD8A16FCBA5B91 = scripts\cp_mp\entityheadicons::setheadicon_singleimage(_id_1E440F4549D5E518, icon, offset, 0, 512, 100, 0, 0, _id_B9352C16DBBDC298, undefined, 1);
}

_id_AFBABC657353367F() {
  if(isDefined(self._id_0AFD8A16FCBA5B91)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self._id_0AFD8A16FCBA5B91);
    self._id_0AFD8A16FCBA5B91 = undefined;
  }
}

_id_B42B8567448E204A(start, end, _id_75BEA58D65510615) {
  _id_C56207BDA09B3A36 = ["physicscontents_foliage", "physicscontents_foliage_audio", "physicscontents_glass", "physicscontents_ainoshoot", "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicleclip", "physicscontents_itemclip", "physicscontents_clipshot", "physicscontents_playerclip", "physicscontents_aiclip", "physicscontents_vehicle", "physicscontents_useclip"];
  contents = physics_createcontents(_id_C56207BDA09B3A36);
  trace = scripts\engine\trace::ray_trace_passed(start, end, _id_75BEA58D65510615, contents);
  return trace;
}

_id_6E57E1D3B53987BE() {
  self endon("disconnect");

  if(!self _meth_6F55D55CCFF20D14()) {
    return;
  }
  _id_18DD74772EE0D1FD(0);
  wait 0.75;
  self._id_AF23415ABF13E8FA = 1;
  wait 1;
  self._id_AF23415ABF13E8FA = undefined;
}

_id_A3070BE4E578D579() {
  foreach(player in level.players) {
    if(istrue(player._id_23A6763562820C70))
      return player;
  }

  return undefined;
}

_id_C3DB6A01F32BC12B() {
  level endon("game_ended");
  level notify("single_hardmode_oxygenmask_use_tracker");
  level endon("single_hardmode_oxygenmask_use_tracker");
  level endon("stop_oxygenmask_hardmode");
  level notify("stop_mantaining_oxy_time");

  if(!isDefined(level._id_C53B399B59B83A64))
    level._id_C53B399B59B83A64 = getdvarint("dvar_BA489EED001F6CAD", 540);

  level thread _id_DF3BC24E6AA5A978();
  owner = undefined;

  if(!istrue(level._id_77F52E0CCB8547EB))
    setomnvar("cp_countdown_timer_alpha", 4);

  for(;;) {
    owner = _id_A3070BE4E578D579();

    if(!isDefined(owner) || !istrue(owner scripts\cp_mp\utility\player_utility::_id_988138367C74B1F5())) {
      level thread _id_DF3BC24E6AA5A978();
      wait 2;
    } else {
      level notify("stop_mantaining_oxy_time");
      waitframe();

      if(!istrue(level._id_77F52E0CCB8547EB))
        setomnvar("cp_countdown_timer", gettime() + level._id_C53B399B59B83A64 * 1000);

      level._id_C53B399B59B83A64--;
      wait 1;
    }

    if(level._id_C53B399B59B83A64 <= 0) {
      level._id_EC0BAA43406DE34A = 1;
      return;
    }
  }
}

_id_DF3BC24E6AA5A978() {
  level endon("game_ended");
  level endon("stop_mantaining_oxy_time");
  level endon("stop_oxygenmask_hardmode");

  for(;;) {
    if(!istrue(level._id_77F52E0CCB8547EB))
      setomnvar("cp_countdown_timer", gettime() + int(level._id_C53B399B59B83A64 * 1000));

    wait 1;
  }
}

_id_0907FEB5CAFF3D13() {
  level endon("game_ended");
  level notify("single_hardmode_oxygenmask_use_tracker");
  level endon("single_hardmode_oxygenmask_use_tracker");
  level endon("stop_oxygenmask_hardmode");

  if(!isDefined(level._id_C53B399B59B83A64))
    level._id_C53B399B59B83A64 = getdvarint("dvar_F762AB013C10BBDC", 100);

  numuses = 0;

  for(;;) {
    level waittill("used_oxygen_mask", player);
    numuses++;
    level._id_C53B399B59B83A64--;

    if(!istrue(level._id_77F52E0CCB8547EB))
      _id_B8A8587BD0E63CA2();

    if(level._id_C53B399B59B83A64 <= 0) {
      level._id_EC0BAA43406DE34A = 1;
      return;
    }
  }
}

_id_B8A8587BD0E63CA2() {
  setomnvar("cp_objective_sub_count_4", int(level._id_C53B399B59B83A64));
  setomnvar("cp_objective_sub_4_index", 98);
}

_id_7EF73B70806A15CD() {
  level notify("stop_oxygenmask_hardmode");
  level._id_5C966A6569A6F4B5 = undefined;

  if(istrue(level._id_77F52E0CCB8547EB)) {
    if(isDefined(level._id_A80E6D45222F9A47) && level._id_A80E6D45222F9A47 > 0) {
      scripts\cp\cp_gameskill::_id_06660798718EE459(0);
      waitframe();
    }
  }

  if(!istrue(level._id_77F52E0CCB8547EB)) {
    setomnvar("cp_countdown_timer", 0);
    setomnvar("cp_countdown_timer_alpha", 0);
    setomnvar("cp_countdown_color", 0);
    waitframe();
  }

  scripts\cp\cp_gameskill::_id_3898E5F82C5C37DF(0);
}

_id_78936156143BF6FA() {
  scripts\cp\tripwire_cp::_id_DC7DB69812DEFCE8(0);
  self._id_FE2B9EE0479AD3CF = "";
  _id_1B4114093CD44368::_id_8B61DAC63B58C6CE("Not Usable");
  self._id_44C22B10C3C644E1 = scripts\cp\utility::set_carry_item(self, "oxygen_tank");
  _id_64A40FAF54EFBDB0();
}

_id_5320A46C0E139CB5() {
  childthread _id_9154DA52B1732C46();
  childthread _id_33FCE193BE4821AA();
  childthread _id_6E57E1D3B53987BE();
  childthread _id_2A830025D8B846F3();

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    scripts\cp\cp_gameskill::_id_3898E5F82C5C37DF(1);
    thread _id_C3DB6A01F32BC12B();
    level._id_5C966A6569A6F4B5 = 1;
  }
}

_id_C6F7C3926E6E4522() {
  _id_1B4114093CD44368::_id_8B61DAC63B58C6CE("Activating");
  _id_18DD74772EE0D1FD(0);
}

_id_CAD73059BABFBE29() {
  _id_18DD74772EE0D1FD(1);
}

_id_FE80C78BD0D58EBF() {
  scripts\cp\tripwire_cp::_id_DC7DB69812DEFCE8(1);
  _id_39DBD79F6E9CD21B();

  if(isDefined(self._id_44C22B10C3C644E1))
    scripts\cp\utility::_id_98F7CA3781DAC77C(self, self._id_44C22B10C3C644E1.carry_ref);

  _id_AFBABC657353367F();
  _id_4D3FA9BAF4CE4BFB();
}

_id_AFB7A317198D0688() {
  self endon("death_or_disconnect");

  if(istrue(level._id_EC0BAA43406DE34A)) {
    return;
  }
  if(istrue(self _meth_635E39FC16A64657()))
    scripts\cp\utility::hint_prompt("cant_use_while_sprintswim", 1, 2);
  else {
    scripts\cp\utility::hint_prompt("cant_use_outside_water", 1, 2);
    return;
  }
}