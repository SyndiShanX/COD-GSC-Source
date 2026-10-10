/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\aitypes\cover.gsc
***********************************************/

#using scripts\aitypes\bt_util;
#using scripts\aitypes\combat;
#using scripts\anim\utility_common;
#using scripts\anim\weaponlist;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace cover;

function getcoverstate() {
  return self._blackboard.coverstate;
}

function shouldlookforinitialcover(taskid) {
  if(isDefined(self.fnshouldlookforcover)) {
    return self[[self.fnshouldlookforcover]](taskid);
  }

  return anim.failure;
}

function lookforinitialcover(taskid) {
  if(isDefined(self.fnlookforcover)) {
    return self[[self.fnlookforcover]](taskid);
  }

  return anim.failure;
}

function lookforbettercover_internal(var_1fe63b952fe3ee08, var_30b84a9cb603754f, coverselector) {
  if(self.arriving) {
    return false;
  }

  if(!isDefined(var_30b84a9cb603754f)) {
    var_30b84a9cb603754f = 0;
  }

  if(self.doingambush) {
    node = self ambushgetnextambushnode();
  } else {
    if(!isDefined(coverselector) && usingmg()) {
      coverselector = % "cover_lmg";
    }

    node = self findbestcovernode(coverselector, var_30b84a9cb603754f);
  }

  if(isDefined(node)) {
    if(!isDefined(self.node) || node != self.node || isDefined(var_1fe63b952fe3ee08) && node != var_1fe63b952fe3ee08) {
      if(self usecovernodeifpossible(node)) {
        if(self.doingambush) {
          if(self ambushcheckpath(node)) {
            return true;
          } else {
            self clearpath();
            self.keepclaimednodeifvalid = 0;
            self.keepclaimednode = 0;
            return false;
          }
        }

        return true;
      }
    }
  }

  return false;
}

function update(task) {
  covernode = self.covernode;
  assert(isDefined(covernode));
  return anim.success;
}

function isdoingambush(task) {
  return self.doingambush;
}

function updatehide(task) {
  self setcoverstate("hide", 1);
  return anim.success;
}

function function_a7f24f5dd4325ccf() {
  var_8a31cf5f87747a = getdvarint(@ "hash_cc4c9095ab9f206f", 0);
  debugentindex = getdvarint(@ "ai_debugentindex");
  return var_8a31cf5f87747a == 1 && (debugentindex == -1 || debugentindex == self getentitynumber());
}

function function_1155b804efae0b2a(reason) {
  if(function_a7f24f5dd4325ccf()) {
    self.var_1155b804efae0b2a = reason;
  }
}

function shouldreload(task, params) {
  assert(isDefined(params));

  if(self.bulletsinclip > weaponclipsize(self.weapon) * params) {
    return anim.failure;
  }

  return anim.success;
}

function terminatehide(task) {}

function shouldchangestanceforfun(task) {
  if(!isDefined(self.enemy)) {
    return anim.failure;
  }

  if(isDefined(self.rambochance) && self.currentpose == "stand") {
    return anim.failure;
  }

  if(self.node.type != "Cover Right" && self.node.type != "Cover Left") {
    return anim.failure;
  }

  if(isnodecover3d(self.node)) {
    return anim.failure;
  }

  if(self.currentpose == "stand" && !self.node doesnodeallowstance("crouch")) {
    return anim.failure;
  }

  if(self.currentpose == "crouch" && !self.node doesnodeallowstance("stand")) {
    return anim.failure;
  }

  if(!isDefined(self.coverchangestanceforfuntime)) {
    setcoverchangestanceforfuntime();
  }

  if(gettime() < self.coverchangestanceforfuntime) {
    return anim.failure;
  }

  return anim.success;
}

function setcoverchangestanceforfuntime() {
  self.coverchangestanceforfuntime = gettime() + randomintrange(5000, 20000);
}

function hasroomtofullexposecorner(node) {
  var_16f58e6bcebc24ca = 36;
  checkpos = node.origin;

  if(isnodecoverright(node)) {
    checkpos += anglestoright(node.angles) * var_16f58e6bcebc24ca;
  } else {
    checkpos += anglestoleft(node.angles) * var_16f58e6bcebc24ca;
  }

  if(!self maymovecheckfriendlyfire(checkpos)) {
    return false;
  }

  if(!ispointonnavmesh(checkpos, self, 1)) {
    return false;
  }

  if(!capsule_trace_passed(node.origin, checkpos, 15, 36, (0, 0, 0), self, create_character_contents())) {
    return false;
  }

  return true;
}

function updatealwayscoverexposed(taskid) {
  if(self.balwayscoverexposed) {
    if(self.health < self.maxhealth * 0.75) {
      self.balwayscoverexposed = 0;
    } else if(isDefined(self._blackboard.scriptableparts) && self._blackboard.scriptableparts.size >= 2) {
      self.balwayscoverexposed = 0;
    }
  }

  return anim.success;
}

function updatecovercroucharrivaltype(taskid) {
  if(!isDefined(self.node) || self.node.type != "Cover Crouch") {
    self._blackboard.croucharrivaltype = undefined;
    self._blackboard.croucharrivalnode = undefined;
    return anim.success;
  }

  if(!isDefined(self._blackboard.croucharrivaltype) || self._blackboard.croucharrivalnode != self.node) {
    pathdisttogoal = self pathdisttogoal();

    if(pathdisttogoal > 0 && pathdisttogoal < 512) {
      covertype = getDvar(@ "hash_f72dde9792b94cc9");

      if(isDefined(self.node.covercrouchtype)) {
        covertype = self.node.covercrouchtype;

        if(covertype != "Cover Right Crouch" && covertype != "Cover Left Crouch" && covertype != "Cover Crouch") {
          covertype = undefined;
        }
      } else if(covertype == "") {
        covertype = undefined;
      }

      self._blackboard.croucharrivalnode = self.node;
      self._blackboard.croucharrivaltype = covertype;
    }
  }

  return anim.success;
}