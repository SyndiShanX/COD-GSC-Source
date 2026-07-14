/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitypes\stealth.gsc
***************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\engine\utility;
#using scripts\smartobjects\utility;
#using scripts\stealth\callbacks;
#using scripts\stealth\event;
#using scripts\stealth\friendly;
#using scripts\stealth\neutral;
#using scripts\stealth\utility;
#namespace stealth;

function initstealthfunctions() {
  self.fnsetstealthstate = &scrsetstealthstate;
  self.fnisinstealthidle = &isidle;
  self.fnisinstealthinvestigate = &isinvestigating;
  self.fnisinstealthhunt = &ishunting;
  self.fnisinstealthcombat = &iscombating;
  self.fnisinstealthidlescriptedanim = &isidlescriptedanim;
  self.fnstealthupdatevisionforlighting = &updatevisionforlighting;
  self.fnstealthisidlecurious = &isidlecurious;
  self.fnclearstealthvolume = &clearstealthvolume;
  self.var_51b8d17f387ac39c = &function_6ec99894b1da2fde;
}

function isidlescriptedanim() {
  return isDefined(self.stealth) && self.stealth_bsmstate == 0 && self._blackboard.idlenodeisvalid;
}

function isidle() {
  return isDefined(self.stealth) && self.stealth_bsmstate == 0;
}

function isinvestigating() {
  return isDefined(self.stealth) && self.stealth_bsmstate == 1;
}

function ishunting() {
  return isDefined(self.stealth) && self.stealth_bsmstate == 2;
}

function iscombating() {
  return isDefined(self.stealth) && self.stealth_bsmstate == 3;
}

function stealth_initfriendly(taskid) {
  friendly::main();
  return anim.success;
}

function stealth_terminatefriendly(taskid) {
  self.stealth = undefined;
  self.stealth_enabled = 0;
}

function stealth_initneutral(taskid) {
  neutral::main();
  return anim.success;
}

function isinlight(lightvalue) {
  if(!isDefined(lightvalue)) {
    return !istrue(level.is_dark);
  }

  return lightvalue >= 0.5;
}

function updatevisionforlighting() {}

function forceflashlightplayercanseeifnecessary() {
  if(isDefined(self.flashlight) && self.flashlight) {
    var_bc629c6e6e7c990 = 0.1;

    foreach(player in level.players) {
      if(isDefined(player.nvg) && isDefined(player.nvg.lightmeter) && player.nvg.lightmeter > var_bc629c6e6e7c990 && isDefined(player.nvg.prevlightmeter) && player.nvg.lightmeter - player.nvg.prevlightmeter > 0.01) {
        if(self aipointinfov(player.origin) && !self cansee(player)) {
          self cansee(player, 0);
        }
      }
    }
  }
}

function function_4dfed540c57ed94(taskid) {
  shouldupdatelightmeter = utility::ent_flag_exist("\x1d\xbd#\x1d\x9b\x12\x9e\xfa\xeb\xb8\xb30 \x84\x06\x98\xe1\xe6\xbe") && utility::ent_flag("\x1d\xbd#\x1d\x9b\x12\x9e\xfa\xeb\xb8\xb30 \x84\x06\x98\xe1\xe6\xbe");

  if(shouldupdatelightmeter && !isDefined(self.lightmeter)) {
    utility::update_light_meter();
    shouldupdatelightmeter = 0;
  }

  updatelightbasedflashlight(self.stealth_bsmstate, 0.5);

  if(shouldupdatelightmeter) {
    entnum = self getentitynumber();
    frametime = level.frameduration;
    assert(isDefined(frametime));

    if(gettime() / frametime % 5 == entnum % 5) {
      utility::update_light_meter();
    }
  }

  forceflashlightplayercanseeifnecessary();
  return anim.success;
}

function function_ec560f01ab473203() {
  if(!self isinscriptedstate()) {
    if(istrue(self.var_3b3bd02c46bdc20c)) {
      self.gunposeoverride_internal = "&oq\xa3 \x15nk";
      return;
    }

    self.gunposeoverride_internal = "\xff\xe7\xd0tt";
  }
}

function updatelightbasedflashlight(state, var_ebd20506905a3881) {
  if(self isinscriptedstate()) {
    return;
  }

  if(gettime() == self.starttime) {
    return;
  }

  lightmeter = self.lightmeter;

  if(getdvarint(@ "hash_7cbaa1208f238b77", 0)) {
    lightmeter = 0;
  }

  if(isDefined(self._blackboard.bflashlight)) {
    var_fe29462b7017529f = self._blackboard.bflashlight;
  } else {
    var_fe29462b7017529f = 0;
  }

  if(isDefined(self.flashlightoverride)) {
    self._blackboard.bflashlight = self.flashlightoverride;
  } else if(istrue(self.noflashlight)) {
    self._blackboard.bflashlight = 0;
  } else if(isDefined(lightmeter)) {
    var_88adcaaa4b16a0d6 = 0.1;

    if(istrue(self._blackboard.bflashlight)) {
      if(lightmeter > var_ebd20506905a3881 + var_88adcaaa4b16a0d6) {
        self._blackboard.bflashlight = 0;
      }
    } else {
      self._blackboard.bflashlight = lightmeter < var_ebd20506905a3881;
    }
  } else if(istrue(level.is_dark)) {
    self._blackboard.bflashlight = 1;
  } else {
    self._blackboard.bflashlight = 0;
  }

  if(var_fe29462b7017529f != self._blackboard.bflashlight) {
    if(asm::asm_getdemeanor() != "T\x1d\xd9\x0e L" && (!isDefined(self.asmflashlight) || !self.asmflashlight)) {
      assert(isDefined(self.fnstealthflashlighton) && isDefined(self.fnstealthflashlightoff));

      if(self._blackboard.bflashlight) {
        self[[self.fnstealthflashlighton]]();
        return;
      }

      self[[self.fnstealthflashlightoff]]();
    }
  }
}

function isidlecurious() {
  return self.stealthidlecurious;
}

function idle_init(taskid) {
  self function_82ebb8252d2eaaa6(1, "\x80T");
  event::event_escalation_clear();

  if(isDefined(self.stealth.funcs["\xf8VZW\xd3\xad"])) {
    callbacks::stealth_call_thread("\xf8VZW\xd3\xad");
  }

  var_56cb0df39b84c565 = utility::function_21a129be478aa01();

  if(!var_56cb0df39b84c565 && isDefined(self.target)) {
    self.goalradius = 32;

    if(isDefined(self.fnstealthgotonode)) {
      self thread[[self.fnstealthgotonode]](undefined, undefined, undefined, undefined);
    }
  }

  return anim.success;
}

function idle_terminate(taskid) {
  self notify("\x83\xcb\xd4\xd6XoZ\xca)\xadaz\x95\x9e\xcf\xa6\xe2\xf1");
  self function_82ebb8252d2eaaa6(0, "\x80T");
  utility::save_last_goal();
  self.last_set_goalnode = undefined;
  self.last_set_goalent = undefined;
  self.moveplaybackrate = 1;
  return anim.success;
}

function hunt_custom_init(taskid) {
  utility::set_patrol_style("\x15'\xa3");

  if(isDefined(self.stealth.funcs["Cus\x1d\xf5\x1bu\xdc\xe8\xdek\xf5\xb4\x9b\x96\xa3"])) {
    self thread[[self.stealth.funcs["Cus\x1d\xf5\x1bu\xdc\xe8\xdek\xf5\xb4\x9b\x96\xa3"]]]();
  }

  return anim.success;
}

function hunt_custom_update(taskid) {
  if(!self.stealth_hunt_iscustom) {
    return anim.failure;
  }

  if(isDefined(self.stealth.funcs["\xeb\x8e\xc8\x1a\x9d=\xa21\x01\x8a\xf7\x9c\x88[\xad\"\x8b\xaf"])) {
    bresult = self[[self.stealth.funcs["\xeb\x8e\xc8\x1a\x9d=\xa21\x01\x8a\xf7\x9c\x88[\xad\"\x8b\xaf"]]]();

    if(isDefined(bresult)) {
      if(bresult) {
        return anim.running;
      } else {
        return anim.failure;
      }
    }
  }

  return anim.running;
}

function hunt_custom_terminate(taskid) {
  if(isDefined(self.stealth.funcs["1\xa8\xdf \xa0C\x15\x1e=\xcd\\)\xce\xac\xae\x11r\x97I\x02L"])) {
    self thread[[self.stealth.funcs["1\xa8\xdf \xa0C\x15\x1e=\xcd\\)\xce\xac\xae\x11r\x97I\x02L"]]]();
  }

  return anim.success;
}

function hunt_active_terminate(taskid) {
  utility::clearsmartobject(asm_bb::bb_getrequestedsmartobject());
  self clearbtgoal(3);
}

function function_5a4448d238750be9(taskid) {
  return anim.failure;
}

function function_c4a7e3afb2f921a1(taskid) {
  return anim.failure;
}

function function_9368b555364063d8(taskid) {
  return anim.failure;
}

function function_66afcb24e8218e78(taskid) {
  return anim.failure;
}

function function_e6dac0b5be2f5f47(taskid) {
  return "%Y\xa3\xbaN\xdc\xd4\xael6+\xcdn";
}

function function_7eeacad5b2f38d13(taskid) {
  return anim.failure;
}

function function_139a041a131263ea(taskid) {}

function function_1c9553f4eea83193() {
  self.var_ec73914830381278 = 0;
  self.var_f825f09f8146eb41 = undefined;
  self.var_299176b51d936d8e = undefined;
}

function clearstealthvolume() {
  if(isDefined(level.stealth.combat_volumes[self.script_stealthgroup]) && iscombating() || isDefined(level.stealth.hunt_volumes[self.script_stealthgroup]) && ishunting()) {
    self clearbtgoal(0);
  }
}

function function_c966b7ad504723e2(event) {
  assert(isDefined(event.typeorig));

  if(isDefined(self.stealth) && istrue(self.stealth_enabled)) {
    self.stealth.investigateevent = event;
    self.var_2063528bc028ac55 = event.typeorig;
    self.var_26b571dd57aaef93 = event.entity;
    self.var_c5d48c2575f43b91 = event.receiver;
    self.var_b91c74669600ea60 = event.type;
    self.var_22008af97670250 = 0;

    if(isDefined(event.position)) {
      self.var_c2346eb7b5421c77 = event.position;
    }

    if(isDefined(event.investigate_pos)) {
      self.var_f447d1dbc0732610 = event.investigate_pos;
    }

    if(isDefined(event.look_pos)) {
      self.var_46cfb663b36eb8a = event.look_pos;
    }
  }
}

function function_6ec99894b1da2fde() {
  if(!(isDefined(self.var_2063528bc028ac55) && isDefined(self.stealth.investigateevent))) {
    return undefined;
  }

  self.stealth.investigateevent.typeorig = self.var_2063528bc028ac55;
  self.stealth.investigateevent.position = self.var_c2346eb7b5421c77;
  self.stealth.investigateevent.entity = self.var_26b571dd57aaef93;
  self.stealth.investigateevent.receiver = self.var_c5d48c2575f43b91;
  self.stealth.investigateevent.type = self.var_b91c74669600ea60;
  self.stealth.investigateevent.investigate_pos = self.var_f447d1dbc0732610;
  self.stealth.investigateevent.look_pos = self.var_46cfb663b36eb8a;
  return self.stealth.investigateevent;
}

function scrsetstealthstate(statename, e) {
  if(!utility::flag("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3") || !isDefined(self.stealth) || !istrue(self.stealth_enabled)) {
    return;
  }

  if(!isalive(self)) {
    return;
  }

  self setstealthstate(statename, e);
}