/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\execution.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\operator;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\engine\utility;
#namespace execution;

function function_1ea3e44fd8a18d1() {
  if(!isDefined(self)) {
    return false;
  }

  if(isbot(self) && getdvarint(@ "hash_eb038ca43332e718", 0) == 0) {
    return false;
  }

  if(istestclient(self)) {
    return false;
  }

  if(scripts\cp_mp\utility\game_utility::getgametype() == "warrior") {
    return false;
  }

  return true;
}

function _giveexecution(ref, isfirstperson) {
  if(!function_1ea3e44fd8a18d1()) {
    return;
  }

  if(istrue(getdvarint(@ "scr_loadout_validate_banned_items", 0)) && scripts\cp_mp\utility\loot::function_8c610908c0e9c6e4(ref)) {
    ref = scripts\cp_mp\operator::function_a9722d35258230d2(self.operatorcustomization.operatorref);
  }

  thread execution_monitor();

  if(function_3b6961b424a382f()) {
    var_25a38dfaf37fc298 = tolower(getDvar(@ "hash_88ba4ca6e5ff9d5a", ""));

    if(isDefined(level.execution.table[var_25a38dfaf37fc298])) {
      ref = var_25a38dfaf37fc298;
    }
  }

  _clearexecution(istrue(isfirstperson));
  propweapon = execution_getpropweaponbyref(ref);

  if(ref == "execution_062" && self.operatorcustomization.operatorref == "inarius_western") {
    propweapon = level.execution.table[ref].propweapon2;
  }

  execution = execution_getexecutionbyref(ref);
  assertex(isDefined(execution), "<dev string:x1c>" + ref);

  if(!isDefined(execution)) {
    return;
  }

  if(isDefined(propweapon)) {
    self giveweapon(propweapon);
    self giveexecution(execution, propweapon, istrue(isfirstperson));
  } else {
    self giveexecution(execution, undefined, istrue(isfirstperson));
  }

  if(istrue(function_700277400dcb7857(ref))) {
    function_43a90e553f84c31c();
  }

  self.executionref = ref;

  if(issharedfuncdefined("game", "lpcFeatureGated") && ![[getsharedfunc("game", "lpcFeatureGated")]]()) {
    thread watchinexecution();
  }
}

function _clearexecution(isfirstperson) {
  if(isDefined(self.executionref)) {
    self clearexecution(istrue(isfirstperson));
    propweapon = execution_getpropweaponbyref(self.executionref);

    if(self.executionref == "execution_062" && self.operatorcustomization.operatorref == "inarius_western") {
      propweapon = "iw9_execution_spear_wings";
    }

    if(isDefined(propweapon) && self hasweapon(propweapon)) {
      self takeweapon(propweapon);
    }

    self.executionref = undefined;
  }
}

function hasexecution() {
  return isDefined(self.executionref);
}

function execution_monitor() {
  self notify("exec_monitor_request");
  self endon("exec_monitor_request");

  while(true) {
    self waittill("execution_begin", victiment);

    if(isDefined(victiment) && (isPlayer(victiment) || isagent(victiment))) {
      victiment notify("execution_begin_victim");
    }

    if(isDefined(self.executionref) && isDefined(self.suit)) {
      thread function_e4ea09e7e5e2d5f1(victiment);
      aliasstring = "mus_" + self.suit + "_" + self.executionref;

      if(soundexists(aliasstring)) {
        self playlocalsound(aliasstring);
        victiment playlocalsound(aliasstring);
      }
    }

    if(isDefined(victiment)) {
      if(isDefined(victiment.basearchetype) && victiment.basearchetype == "zombie_base") {
        victiment setentitysoundcontext("gender", "zombie");
      }
    }

    wait 2;
  }
}

function function_e4ea09e7e5e2d5f1(victiment) {
  self endon("death_or_disconnect");
  self endon("execution_stopped");
  victiment endon("disconnect");

  if(isai(victiment)) {
    return;
  }

  var_ff5b782e4a5bcc05 = victiment getstance();

  switch (self.executionref) {
    case #"hash_272e44a6335fe57":
      switch (var_ff5b782e4a5bcc05) {
        case #"hash_c6775c88e38f7803":
          wait 1.2;
          self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce04", self);
          break;
        case #"hash_3fed0cbd303639eb":
          wait 1.2;
          self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce04", self);
          break;
        case #"hash_d91940431ed7c605":
          if(istrue(victiment.inlaststand)) {
            wait 1.6;
            self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce06", self);
            break;
          } else {
            wait 2;
            self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce05", self);
            break;
          }
        default:
          break;
      }

      break;
    case #"hash_982264d83dbf6f8d":
      switch (var_ff5b782e4a5bcc05) {
        case #"hash_c6775c88e38f7803":
          wait 1.2;
          self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce04", self);
          break;
        case #"hash_3fed0cbd303639eb":
          wait 1.2;
          self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce04", self);
          break;
        case #"hash_d91940431ed7c605":
          if(istrue(victiment.inlaststand)) {
            wait 1.6;
            self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce06", self);
            break;
          } else {
            wait 2;
            self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce05", self);
            break;
          }
        default:
          break;
      }

      break;
    case #"hash_a12a71571e6da63":
      switch (var_ff5b782e4a5bcc05) {
        case #"hash_c6775c88e38f7803":
          wait 2.9;
          self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce12", self);
          break;
        case #"hash_3fed0cbd303639eb":
          wait 2.9;
          self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce12", self);
          break;
        case #"hash_d91940431ed7c605":
          if(istrue(victiment.inlaststand)) {
            wait 1.5;
            self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce11", self);
            break;
          } else {
            wait 1.6;
            self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce10", self);
            break;
          }
        default:
          break;
      }

      break;
    case #"hash_84b68933c178cd09":
      switch (var_ff5b782e4a5bcc05) {
        case #"hash_c6775c88e38f7803":
          wait 2.9;
          self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce12", self);
          break;
        case #"hash_3fed0cbd303639eb":
          wait 2.9;
          self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce12", self);
          break;
        case #"hash_d91940431ed7c605":
          if(istrue(victiment.inlaststand)) {
            wait 1.5;
            self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce11", self);
            break;
          } else {
            wait 1.6;
            self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce10", self);
            break;
          }
        default:
          break;
      }

      break;
    case #"hash_108f7f3680e4cb4a":
      switch (var_ff5b782e4a5bcc05) {
        case #"hash_c6775c88e38f7803":
          wait 2.3;
          self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce03", self);
          break;
        case #"hash_3fed0cbd303639eb":
          wait 2.3;
          self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce03", self);
          break;
        case #"hash_d91940431ed7c605":
          if(istrue(victiment.inlaststand)) {
            wait 0.2;
            self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce02", self);
            break;
          } else {
            wait 2.5;
            self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce01", self);
            break;
          }
        default:
          break;
      }

      break;
    case #"hash_35045a42d684bc52":
      switch (var_ff5b782e4a5bcc05) {
        case #"hash_c6775c88e38f7803":
          wait 2.3;
          self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce03", self);
          break;
        case #"hash_3fed0cbd303639eb":
          wait 2.3;
          self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce03", self);
          break;
        case #"hash_d91940431ed7c605":
          if(istrue(victiment.inlaststand)) {
            wait 0.2;
            self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce02", self);
            break;
          } else {
            wait 2.5;
            self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce01", self);
            break;
          }
        default:
          break;
      }

      break;
    case #"hash_279ef6d5b4d7862a":
      switch (var_ff5b782e4a5bcc05) {
        case #"hash_c6775c88e38f7803":
          wait 1.7;
          self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce15", self);
          break;
        case #"hash_3fed0cbd303639eb":
          wait 1.7;
          self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce15", self);
          break;
        case #"hash_d91940431ed7c605":
          if(istrue(victiment.inlaststand)) {
            wait 1;
            self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce14", self);
            break;
          } else {
            wait 1.5;
            self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce13", self);
            break;
          }
        default:
          break;
      }

      break;
    case #"hash_17f631e350a58072":
      switch (var_ff5b782e4a5bcc05) {
        case #"hash_c6775c88e38f7803":
          wait 1.7;
          self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce15", self);
          break;
        case #"hash_3fed0cbd303639eb":
          wait 1.7;
          self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce15", self);
          break;
        case #"hash_d91940431ed7c605":
          if(istrue(victiment.inlaststand)) {
            wait 1;
            self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce14", self);
            break;
          } else {
            wait 1.5;
            self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce13", self);
            break;
          }
        default:
          break;
      }

      break;
    case #"hash_8d44865c9e264f78":
      switch (var_ff5b782e4a5bcc05) {
        case #"hash_c6775c88e38f7803":
          wait 2.9;
          self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce07", self);
          break;
        case #"hash_3fed0cbd303639eb":
          wait 2.9;
          self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce07", self);
          break;
        case #"hash_d91940431ed7c605":
          if(istrue(victiment.inlaststand)) {
            wait 1.3;
            self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce09", self);
            break;
          } else {
            wait 2.8;
            self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce08", self);
            break;
          }
        default:
          break;
      }

      break;
    case #"hash_f4ad44ebf245e754":
      switch (var_ff5b782e4a5bcc05) {
        case #"hash_c6775c88e38f7803":
          wait 2.9;
          self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce07", self);
          break;
        case #"hash_3fed0cbd303639eb":
          wait 2.9;
          self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce07", self);
          break;
        case #"hash_d91940431ed7c605":
          if(istrue(victiment.inlaststand)) {
            wait 1.3;
            self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce09", self);
            break;
          } else {
            wait 2.8;
            self playsoundtoplayer("dx_mp_mpce_cste_ctrd_ce08", self);
            break;
          }
        default:
          break;
      }

      break;
    default:
      break;
  }
}

function execution_init() {
  assertex(!isDefined(level.execution), "<dev string:x3c>");
  level.execution = spawnStruct();
  level.enableexecutionattackfunc = &enableexecutionattackwrapper;
  level.disableexecutionattackfunc = &disableexecutionattackwrapper;
  level.enableexecutionvictimfunc = &enableexecutionvictimwrapper;
  level.disableexecutionvictimfunc = &disableexecutionvictimwrapper;
  execution_loadtable();

  if(issharedfuncdefined("execution", "init")) {
    [[getsharedfunc("execution", "init")]]();
  }
}

function enableexecutionattackwrapper() {
  self enableexecutionattack();
}

function disableexecutionattackwrapper() {
  self disableexecutionattack();
}

function enableexecutionvictimwrapper() {
  self enableexecutionvictim();
}

function disableexecutionvictimwrapper() {
  self disableexecutionvictim();
}

function execution_loadtable() {
  level.execution.table = [];

  foreach(executionref in scripts\cp_mp\operator::function_232a4826a2bd2bfd()) {
    struct = spawnStruct();
    struct.ref = executionref;
    id = scripts\cp_mp\operator::function_3daf6bb451cf826e(executionref);
    assertex(isDefined(id), "<dev string:x69>" + executionref + "<dev string:x82>");
    struct.id = int(id);
    execution = scripts\cp_mp\operator::function_75322d3c8f9c9ccb(executionref);
    assertex(isDefined(execution) && execution != "<dev string:x92>", "<dev string:x69>" + executionref + "<dev string:x96>");

    if(execution != "none") {
      struct.execution = execution;
    }

    propweapon = scripts\cp_mp\operator::function_3bd82b573b8f64f3(executionref);
    assertex(isDefined(propweapon) && propweapon != "<dev string:x92>", "<dev string:x69>" + executionref + "<dev string:xad>");

    if(propweapon != "none") {
      struct.propweapon = makeweapon(propweapon);

      if(execution == "execution_062") {
        struct.propweapon2 = "iw9_execution_spear_wings";
      }

      if(isnullweapon(struct.propweapon)) {
        continue;
      }
    }

    level.execution.table[executionref] = struct;
  }
}

function execution_getexecutionbyref(ref) {
  assertex(isDefined(level.execution), "<dev string:xc6>");
  struct = level.execution.table[ref];

  if(isDefined(struct)) {
    return struct.execution;
  }

  return undefined;
}

function execution_getpropweaponbyref(ref) {
  assertex(isDefined(level.execution), "<dev string:x103>");
  struct = level.execution.table[ref];

  if(isDefined(struct)) {
    return struct.propweapon;
  }

  return undefined;
}

function execution_getrefbyplayer(player) {
  return player.executionref;
}

function execution_getidbyref(ref) {
  assertex(isDefined(level.execution), "<dev string:x141>");
  struct = level.execution.table[ref];

  if(isDefined(struct)) {
    return struct.id;
  }
}

function function_700277400dcb7857(ref) {
  assertex(isDefined(level.execution), "<dev string:x141>");

  if(!isDefined(ref)) {
    return 0;
  }

  struct = level.execution.table[ref];

  if(isDefined(struct)) {
    return istrue(struct.petenabled);
  }
}

function function_43a90e553f84c31c() {
  scripts\common\values::set("pet_execution", "hide_operator_backpack", 1);
}

function execution_blockladders() {
  if(self isonladder()) {
    if(!istrue(self.ladderexecutionblocked)) {
      val::set("ladderExecution", "execution_attack", 0);
      val::set("ladderExecution", "execution_victim", 0);
      self.ladderexecutionblocked = 1;
    }

    return;
  }

  if(istrue(self.ladderexecutionblocked)) {
    val::reset_all("ladderExecution");
    self.ladderexecutionblocked = undefined;
  }
}

function watchinexecution() {
  self endon("disconnect");
  self notify("watchInExecution");
  self endon("watchInExecution");
  var_a9ee87cc06bd6b39 = 0;

  while(true) {
    inexecution = self isinexecutionattack() || self isinexecutionvictim();

    if(inexecution != var_a9ee87cc06bd6b39 && !scripts\common\utility::isusingremote()) {
      if(inexecution) {
        self enablephysicaldepthoffieldscripting();
        self setphysicaldepthoffield(2.5, 60, 20, 20);
      } else {
        self disablephysicaldepthoffieldscripting();
        self notify("execution_stopped");
      }
    }

    var_a9ee87cc06bd6b39 = inexecution;
    waitframe();
  }
}

function is_in_takedown() {
  return self isinexecutionvictim() || self isinexecutionattack();
}