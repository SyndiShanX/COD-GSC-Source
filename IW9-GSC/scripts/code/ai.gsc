/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\code\ai.gsc
***********************************************/

free_expendable() {
  if(!isDefined(self.spawner) || !isDefined(self.script_suspend)) {
    return;
  }
  spawner = self.spawner;
  struct = spawnStruct();
  struct.origin = self.origin;
  struct.angles = self.angles;
  struct.suspendtime = gettime();

  if(isDefined(self.suspendvars))
    struct.suspendvars = self.suspendvars;
  else
    struct.suspendvars = spawnStruct();

  if(isDefined(self.stealth)) {
    struct.stealth = spawnStruct();
    struct.stealth.bsmstate = self._id_FE5EBEFA740C7106;

    if(isDefined(self._id_743F5EEB386835F5))
      struct.stealth.investigateevent = self[[self._id_743F5EEB386835F5]]();
  }

  if(isDefined(self.node)) {
    if(isDefined(self.using_goto_node)) {
      if(isDefined(self.node.targetname))
        struct.target = self.node.targetname;

      struct.node = self.node;
    }

    struct.target = self.node.targetname;
  }

  spawner.suspended_ai = struct;

  if(isDefined(self.script_suspend_group) && !isDefined(self.script_free))
    free_groupname(self.script_suspend_group);
}

free_groupname(groupname) {
  if(!isDefined(level.processfreegroupname))
    level.processfreegroupname = [];

  if(isDefined(level.processfreegroupname[groupname])) {
    return;
  }
  level.processfreegroupname[groupname] = 1;
  _id_DA96C8943126A950 = getaiarray();

  foreach(ai in _id_DA96C8943126A950) {
    if(ai == self) {
      continue;
    }
    if(!isDefined(ai.script_suspend_group)) {
      continue;
    }
    if(ai.script_suspend_group != groupname) {
      continue;
    }
    ai.script_free = 1;
    ai free_expendable();
    ai delete();
  }

  level.processfreegroupname[groupname] = undefined;
}

create_weapon_in_script(weaponarray, _id_E46130A1F1555462) {
  if(!isDefined(level.fnscriptedweaponassignment)) {
    self.usescriptedweapon = undefined;

    if(!isDefined(weaponarray))
      weapon = nullweapon();
    else if(!isarray(weaponarray) && weaponarray == "")
      weapon = nullweapon();
    else if(isarray(weaponarray))
      weapon = makeweapon(weaponarray[randomint(weaponarray.size)]);
    else
      weapon = makeweapon(weaponarray);

    if(!isnullweapon(weapon)) {
      self.scriptedweaponfailed = 1;

      if(isDefined(_id_E46130A1F1555462) && _id_E46130A1F1555462 == "sidearm")
        self.scriptedweaponfailed_sidearmarray = weaponarray;
      else
        self.scriptedweaponfailed_primaryarray = weaponarray;
    }

    return weapon;
  } else
    return [[level.fnscriptedweaponassignment]](weaponarray, _id_E46130A1F1555462);
}

_id_3A249A1F1AECBB0E(_id_65769CBDBC09AD59, ai, param1, param2, param3, param4) {
  result = undefined;

  if(isDefined(level.stealth._id_E376D807BB8CE93B))
    result = ai[[level.stealth._id_E376D807BB8CE93B]](_id_65769CBDBC09AD59, param1, param2, param3, param4);

  return istrue(result);
}

_id_9AEAD378CA03CB28(_id_77ED885C718B50AC, position, _id_93A30E5888017BAE) {
  if(isDefined(level._id_74E9C02B56E4BA52))
    [[level._id_74E9C02B56E4BA52]](_id_77ED885C718B50AC, position, _id_93A30E5888017BAE);
}

_id_41FF5020F8762668(ent, _id_93A30E5888017BAE) {
  if(isDefined(level._id_8A42B71F799936AD))
    [[level._id_8A42B71F799936AD]](ent, _id_93A30E5888017BAE);
}

_id_D5EE270AFC41E925(_id_93A30E5888017BAE) {
  if(isDefined(level._id_19EF4572543C12C1))
    return [[level._id_19EF4572543C12C1]](_id_93A30E5888017BAE);

  return 1;
}

_id_8FF6B395C2615881(_id_65769CBDBC09AD59, requestid, data) {
  if(isDefined(level._id_03AE5F7DE11D142F))
    return [[level._id_03AE5F7DE11D142F]](_id_65769CBDBC09AD59, requestid, data);
}

_id_2392636ED67E9FED() {}

_id_56543479237033C3() {
  return::_id_2392636ED67E9FED;
}

_id_74939CB3D7C3057B() {
  _id_87DC2DB63D1CFE13();
}

_id_87DC2DB63D1CFE13() {
  if(1) {
    _id_05960B342A6EF48D = spawnStruct();
    _id_05960B342A6EF48D._id_73D903554C10EC93[0] = spawnStruct();
    _id_05960B342A6EF48D._id_73D903554C10EC93[0].name = "default";
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[0] = spawnStruct();
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[0].types = "aim_only";
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[0]._id_B12D12BEACE49802 = spawnStruct();
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[0]._id_B12D12BEACE49802.speed = 80.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[0].action = spawnStruct();
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[0].action._id_C84C06A4463EE99C = 24.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[0].action._id_D40D255AB3B9623B = 90.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[0].action._id_FB95AD1022E86854 = 90.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[0].action._id_01373755BB3B8C41 = 32.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[0]._id_870DA6F4DD17F6A6 = spawnStruct();
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[0]._id_870DA6F4DD17F6A6._id_D1E64A8DA97C5F9A = 170.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[0]._id_870DA6F4DD17F6A6._id_D40D255AB3B9623B = 70.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[0]._id_870DA6F4DD17F6A6._id_FB95AD1022E86854 = 70.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[0]._id_870DA6F4DD17F6A6._id_01373755BB3B8C41 = 32.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[1] = spawnStruct();
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[1].types = "strafe_only";
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[1]._id_B12D12BEACE49802 = spawnStruct();
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[1]._id_B12D12BEACE49802.speed = 60.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[1].action = spawnStruct();
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[1].action._id_C84C06A4463EE99C = 24.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[1].action._id_D40D255AB3B9623B = 180.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[1].action._id_FB95AD1022E86854 = 120.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[1].action._id_01373755BB3B8C41 = 32.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[1].action._id_2EFD5C4E05AC0023 = 0.5;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[1]._id_870DA6F4DD17F6A6 = spawnStruct();
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[1]._id_870DA6F4DD17F6A6._id_D1E64A8DA97C5F9A = 170.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[1]._id_870DA6F4DD17F6A6._id_D40D255AB3B9623B = 90.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[1]._id_870DA6F4DD17F6A6._id_FB95AD1022E86854 = 90.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[1]._id_870DA6F4DD17F6A6._id_01373755BB3B8C41 = 32.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[2] = spawnStruct();
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[2].types = "shallow";
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[2]._id_B12D12BEACE49802 = spawnStruct();
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[2]._id_B12D12BEACE49802.speed = 49.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[2]._id_B12D12BEACE49802._id_B9F5DF1B7D672272 = 75.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[2].action = spawnStruct();
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[2].action._id_C84C06A4463EE99C = 24.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[2].action._id_01373755BB3B8C41 = 32.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[2]._id_9A0EF637629E8188 = spawnStruct();
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[2]._id_9A0EF637629E8188._id_832C9AA8484AF5BB = 48.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[2]._id_870DA6F4DD17F6A6 = spawnStruct();
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[2]._id_870DA6F4DD17F6A6._id_26E073F24350C158 = 40.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[2]._id_870DA6F4DD17F6A6._id_D1E64A8DA97C5F9A = 135.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[2]._id_870DA6F4DD17F6A6.maxspeed = 50.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[2]._id_870DA6F4DD17F6A6._id_BF6DE6A2E4793C3A = "cautious_shallow_corner_check";
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_820A92B1182AE83E[2]._id_870DA6F4DD17F6A6._id_01373755BB3B8C41 = 32.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_8AB8AA563ABB4083[0] = spawnStruct();
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_8AB8AA563ABB4083[0].types = "shallow";
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_8AB8AA563ABB4083[0].speed = 80.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_8AB8AA563ABB4083[0]._id_47044115B7FA1278 = 75.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_1AFD01823BB3D66F[0] = spawnStruct();
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_1AFD01823BB3D66F[0].types = "shallow";
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_1AFD01823BB3D66F[0]._id_BF6DE6A2E4793C3A = "cornercheck_shallow_fast";
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_1AFD01823BB3D66F[0].maxspeed = 90.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_1AFD01823BB3D66F[0].minspeed = 75.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_1AFD01823BB3D66F[0]._id_26E073F24350C158 = 40.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_1AFD01823BB3D66F[0]._id_D1E64A8DA97C5F9A = 135.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[0]._id_03951CABC31D342F = 6.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[1] = _func_7E7B315FCB2B9159(_id_05960B342A6EF48D._id_73D903554C10EC93[0], 1);
    _id_05960B342A6EF48D._id_73D903554C10EC93[1].name = "nightwar_start";
    _id_05960B342A6EF48D._id_73D903554C10EC93[1]._id_F4D3813E43115B14 = "shallow";
    _id_05960B342A6EF48D._id_73D903554C10EC93[1]._id_820A92B1182AE83E[0]._id_7D3CF95BDBCA0939 = spawnStruct();
    _id_05960B342A6EF48D._id_73D903554C10EC93[1]._id_820A92B1182AE83E[0]._id_7D3CF95BDBCA0939._id_06BB8B086CBAE934 = 0.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[1]._id_820A92B1182AE83E[0]._id_7D3CF95BDBCA0939._id_5F5E6A9E5B0D045F = 0.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[1]._id_820A92B1182AE83E[1]._id_7D3CF95BDBCA0939 = spawnStruct();
    _id_05960B342A6EF48D._id_73D903554C10EC93[1]._id_820A92B1182AE83E[1]._id_7D3CF95BDBCA0939._id_06BB8B086CBAE934 = 0.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[1]._id_820A92B1182AE83E[1]._id_7D3CF95BDBCA0939._id_5F5E6A9E5B0D045F = 0.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[1]._id_820A92B1182AE83E[2]._id_7D3CF95BDBCA0939 = spawnStruct();
    _id_05960B342A6EF48D._id_73D903554C10EC93[1]._id_820A92B1182AE83E[2]._id_7D3CF95BDBCA0939._id_06BB8B086CBAE934 = 0.0;
    _id_05960B342A6EF48D._id_73D903554C10EC93[1]._id_820A92B1182AE83E[2]._id_7D3CF95BDBCA0939._id_5F5E6A9E5B0D045F = 0.0;
    _func_6B4AB6C856A01415("component", _id_05960B342A6EF48D, "ai_cornercheck_behaviors", "ai_cornercheck_behaviors_default_script");
  }

  if(1) {
    _id_DAF5681B8A09C71C = spawnStruct();
    _id_DAF5681B8A09C71C._id_73D903554C10EC93[0] = spawnStruct();
    obj = _id_DAF5681B8A09C71C._id_73D903554C10EC93[0];
    obj.name = "cover_right";
    obj._id_8ACF2C9C4F6D6A58 = 15.0;
    obj._id_4F8A7CC0BDEA8A8D = 30.0;
    obj._id_90F2FB36D1E4FBB8 = 20.0;
    obj._id_56B54F5705CD766D = 30.0;
    _id_DAF5681B8A09C71C._id_73D903554C10EC93[1] = spawnStruct();
    obj = _id_DAF5681B8A09C71C._id_73D903554C10EC93[1];
    obj.name = "cover_left";
    obj._id_8ACF2C9C4F6D6A58 = 60.0;
    obj._id_4F8A7CC0BDEA8A8D = 15.0;
    obj._id_90F2FB36D1E4FBB8 = 20.0;
    obj._id_56B54F5705CD766D = 30.0;
    _id_DAF5681B8A09C71C._id_73D903554C10EC93[2] = spawnStruct();
    obj = _id_DAF5681B8A09C71C._id_73D903554C10EC93[2];
    obj.name = "cover_crouch";
    obj._id_8ACF2C9C4F6D6A58 = 15.0;
    obj._id_4F8A7CC0BDEA8A8D = 45.0;
    obj._id_90F2FB36D1E4FBB8 = 20.0;
    obj._id_56B54F5705CD766D = 30.0;
    _id_DAF5681B8A09C71C._id_73D903554C10EC93[3] = spawnStruct();
    obj = _id_DAF5681B8A09C71C._id_73D903554C10EC93[3];
    obj.name = "exposed";
    obj._id_8ACF2C9C4F6D6A58 = 45.0;
    obj._id_4F8A7CC0BDEA8A8D = 45.0;
    obj._id_90F2FB36D1E4FBB8 = 30.0;
    obj._id_56B54F5705CD766D = 30.0;
    _id_DAF5681B8A09C71C._id_73D903554C10EC93[4] = spawnStruct();
    obj = _id_DAF5681B8A09C71C._id_73D903554C10EC93[4];
    obj.name = "default";
    obj._id_8ACF2C9C4F6D6A58 = 60.0;
    obj._id_4F8A7CC0BDEA8A8D = 60.0;
    obj._id_90F2FB36D1E4FBB8 = 45.0;
    obj._id_56B54F5705CD766D = 45.0;
    _func_6B4AB6C856A01415("component", _id_DAF5681B8A09C71C, "ai_lookat_behaviors", "ai_lookat_behaviors_default_script");
  }

  if(1) {
    _id_03F42592F8E297EA = spawnStruct();
    _id_03F42592F8E297EA._id_21C27C0AC99D29ED[0] = spawnStruct();
    _id_03F42592F8E297EA._id_21C27C0AC99D29ED[0]._id_DE94E5D776CDC165 = "cover_right";
    _id_03F42592F8E297EA._id_21C27C0AC99D29ED[0]._id_A3476363CA654E1C[0] = "cover_right_crouch";
    _id_03F42592F8E297EA._id_21C27C0AC99D29ED[0]._id_A3476363CA654E1C[1] = "cover_right";
    _id_03F42592F8E297EA._id_21C27C0AC99D29ED[1] = spawnStruct();
    _id_03F42592F8E297EA._id_21C27C0AC99D29ED[1]._id_DE94E5D776CDC165 = "cover_left";
    _id_03F42592F8E297EA._id_21C27C0AC99D29ED[1]._id_A3476363CA654E1C[0] = "cover_left_crouch";
    _id_03F42592F8E297EA._id_21C27C0AC99D29ED[1]._id_A3476363CA654E1C[1] = "cover_left";
    _id_03F42592F8E297EA._id_21C27C0AC99D29ED[2] = spawnStruct();
    _id_03F42592F8E297EA._id_21C27C0AC99D29ED[2]._id_DE94E5D776CDC165 = "cover_crouch";
    _id_03F42592F8E297EA._id_21C27C0AC99D29ED[2]._id_A3476363CA654E1C[0] = "cover_crouch";
    _id_03F42592F8E297EA._id_21C27C0AC99D29ED[3] = spawnStruct();
    _id_03F42592F8E297EA._id_21C27C0AC99D29ED[3]._id_DE94E5D776CDC165 = "exposed";
    _id_8B462903A1F84F9C[0] = "cover_right_crouch_stand";
    _id_8B462903A1F84F9C[_id_8B462903A1F84F9C.size] = "cover_right_crouch_exposed_left";
    _id_8B462903A1F84F9C[_id_8B462903A1F84F9C.size] = "cover_right_crouch_exposed_right";
    _id_8B462903A1F84F9C[_id_8B462903A1F84F9C.size] = "cover_left_crouch_stand";
    _id_8B462903A1F84F9C[_id_8B462903A1F84F9C.size] = "cover_left_crouch_exposed_left";
    _id_8B462903A1F84F9C[_id_8B462903A1F84F9C.size] = "cover_left_crouch_exposed_right";
    _id_8B462903A1F84F9C[_id_8B462903A1F84F9C.size] = "cover_left_crouch_exposed_a";
    _id_8B462903A1F84F9C[_id_8B462903A1F84F9C.size] = "cover_left_crouch_exposed_b";
    _id_8B462903A1F84F9C[_id_8B462903A1F84F9C.size] = "cover_right_crouch_exposed_a";
    _id_8B462903A1F84F9C[_id_8B462903A1F84F9C.size] = "cover_right_crouch_exposed_b";
    _id_8B462903A1F84F9C[_id_8B462903A1F84F9C.size] = "cover_left_exposed_a";
    _id_8B462903A1F84F9C[_id_8B462903A1F84F9C.size] = "cover_left_exposed_b";
    _id_8B462903A1F84F9C[_id_8B462903A1F84F9C.size] = "cover_right_exposed_a";
    _id_8B462903A1F84F9C[_id_8B462903A1F84F9C.size] = "cover_right_exposed_b";
    _id_8B462903A1F84F9C[_id_8B462903A1F84F9C.size] = "exposed_idle";
    _id_8B462903A1F84F9C[_id_8B462903A1F84F9C.size] = "cover_stand";
    _id_03F42592F8E297EA._id_21C27C0AC99D29ED[3]._id_A3476363CA654E1C = _id_8B462903A1F84F9C;
    _func_6B4AB6C856A01415("component", _id_03F42592F8E297EA, "ai_lookat_anim_mappings", "ai_lookat_anim_mappings_default_script");
  }

  if(1) {
    _id_B8C784BB7E525FCF = spawnStruct();
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0] = spawnStruct();
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0].name = "default";
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_AF4BDC6F4521ECBA = getdvarfloat("dvar_F8240D5C0C37AC7E", 0.4);
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_71AB7138C82E0414 = getdvarfloat("dvar_960BB94E318DB890", 1.2);
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_6FF73A4C2DECC237 = 55.0;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_093185D472B55082 = 120.0;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_8B7A4DC6E1256321 = 200.0;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_D99757891D1ED279 = 300.0;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_ACDFCBF564707132 = -300.0;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_26E7C5C27C4A71A5 = 200.0;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_810F84117B47D883 = 300.0;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_97184E9F093EA3A0 = 550.0;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_12FA7E4BF627B292 = 700.0;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_8756726934E12803 = 1000.0;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_3AFD9CF782198639 = 0.0;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_C50883E1120A978E = 20.0;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_3FACD58886DFD323 = 1500;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_6358E5C58D47F837 = 1000;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_F1B25456120283F0 = 3000;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_4AB749AAD99E7631 = 4000;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_63BC3F012AC7583E = 2000;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_E1283F20324CB7DD = 100.0;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_2B44A72E6286CAE7 = 4000;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_2EFB9DE526ADD856 = 10000;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_C6E764480E140C79 = 512.0;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_F5F29F48BF54F95E = 0.86;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_E773207DE29064C4 = 200.0;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_73849610029138D6 = 2500;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_E3462E8BCC2C2BBB = 7000;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_91ADC28CE868E001 = 8000;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_D6C13152AC9AA81D = 1000;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_EE7E07BDBDAE989B = 1250;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_F5D9E4CDCE6FC2F9 = 200.0;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_F23D7D041B2ACFB3 = 300.0;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_FA40AEF304CAB126 = 600.0;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_DB66DD499F459CDA = 50.0;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_DAFBEF1CC10672C0 = 100.0;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_97D83C01D694EBEF = 200.0;
    _id_B8C784BB7E525FCF._id_65411979A9F55A1C[0]._id_4DDFC5D089928B41 = 300.0;
    _func_6B4AB6C856A01415("component", _id_B8C784BB7E525FCF, "ai_jailer_settings", "ai_jailer_settings_default_script");
  }
}