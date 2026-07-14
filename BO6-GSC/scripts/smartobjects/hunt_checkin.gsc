/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\smartobjects\hunt_checkin.gsc
*************************************************/

#using scripts\asm\asm;
#using scripts\asm\gesture;
#using scripts\smartobjects\utility;
#using scripts\stealth\group;
#namespace hunt_checkin;

function main() {
  utility::add_smartobject_type("\nCSC\xb03+\x9f\xbar\x98\x18", &getinfo, &canuse);
}

function canuse(object) {
  return true;
}

function getinfo() {
  info = utility::createsmartobjectinfo();
  info.fnonuse = &onuse;
  info.var_76e0326a9756a619 = 1;
  info.radiussqrd = 3600;
  info.nextusetime = 0;
  info utility::addsmartobjectanim("\xd0\xce\x88\x9e");
  return info;
}

function onuse(object) {
  pod = undefined;
  assert(isDefined(pod));
  job = pod group::function_8f107765e4a102f7(self);
  otherguy = job.guys[0];

  if(self == otherguy) {
    otherguy = job.guys[1];
  }

  var_dae9df780a8ea40b = otherguy.var_7fe609f94904e7bf;

  if(self == job.leader) {
    exit_wait = randomintrange(1200, 3600);
    self.var_775c82890c81de22 = self.origin;
    self.stealth.script_skiplookaroundanim = 1;
    self.stealth.script_huntlookaroundduration = exit_wait;
    gesture::ai_request_gesture("\x166x\x98", undefined, 1000, "\xe7\xa9BqTXlmfH^\akc4\xf5\xf2%");
    self waittill("\xe7\xa9BqTXlmfH^\akc4\xf5\xf2%");

    if(!isDefined(var_dae9df780a8ea40b)) {
      gesture::ai_request_gesture("\x166x\x98", undefined, 1000, "\x18\x06p?\x87\xd3k:\x12\x8e\\\xdf");
    } else {
      self setlookat(var_dae9df780a8ea40b, 1);
      gesture::ai_request_gesture("\x13\ft_\x02t\x83\xf5\xcb\xd3\f\xe4\x9f\xc3", var_dae9df780a8ea40b, 1000, "\x18\x06p?\x87\xd3k:\x12\x8e\\\xdf");
    }

    thread waitforgesture("\x18\x06p?\x87\xd3k:\x12\x8e\\\xdf");
    return;
  }

  gesture::ai_request_gesture("6\x95", undefined, 1000, "\x18\x06p?\x87\xd3k:\x12\x8e\\\xdf");
  thread waitforgesture("\x18\x06p?\x87\xd3k:\x12\x8e\\\xdf");
}

function waitforgesture(flag) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x12\xb0x\xf2Z/Gz\xb9W\x14\xce\v~ \x94\xf6\xf3c\x9e\x12\bQ\xf8\xbb ");
  childthread waitforgesture_timeout(10);

  while(true) {
    self waittill(flag, status);

    if(status == "\xc4\xc4Vbv\xf5&\xd8G<~UF\xb6" || status == "\x97\xe9\x15\x96\x1d\xe5\x1b\f3,\xa5&\x90\xf8") {
      break;
    }
  }

  asm::asm_fireevent(self.asmname, "\xac\x183\x12\xb2o\xab\x9en\x9f\x95\x99\x0e0\x10\r\xac@1\f");
}

function waitforgesture_timeout(t) {
  wait t;
  asm::asm_fireevent(self.asmname, "\xac\x183\x12\xb2o\xab\x9en\x9f\x95\x99\x0e0\x10\r\xac@1\f");
}