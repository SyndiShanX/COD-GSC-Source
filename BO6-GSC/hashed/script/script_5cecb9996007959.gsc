/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_5cecb9996007959.gsc
****************************************************/

#using scripts\asm\asm;
#using scripts\common\cap;
#namespace use_armor_plate_solo;

function getfunction(funcid) {
  switch (funcid) {
    case #"hash_dab0d83df51da4d":
      return &onuserinit;
    case #"hash_722d767fd6d40f56":
      return &onuserterminate;
    case #"hash_902f9e79d5e57c83":
      return &oneventreceived;
    case #"hash_1637227a26307eb5":
      return &setstationary;
    case #"hash_6279e013ab5c4fdd":
      return &usearmorplate;
  }

  assertmsg("<dev string:x24>" + funcid);
}

function onuserinit(interactionid) {}

function onuserterminate(interactionid) {
  self clearbtgoal(1);
  self notify("\x01\xb3\xf0\xd2u\n*\xc8\xce\x16\x1a\xcc\x89?\x14\x0e");

  if(isagent(self)) {
    assert(self isscriptable(), "<dev string:x45>" + self.agent_type + "<dev string:x55>");
  }

  scriptablepart = "A\x88\xb4\xb63.PxqW\xc6";

  if(self isscriptable() && self getscriptablehaspart(scriptablepart)) {
    self setscriptablepartstate(scriptablepart, "\x91\xca\xcc\v\xab\xd8:");
  }

  if(isalive(self) && self.asmname == "\xe7\x92\xbf\x14\xb5\xc5\xf2\x16\xc4\x04\x85\xdaG\x92Y\xdb\xd6\aa0\nW\xb8\xd5") {
    cap::cap_exit();
  }
}

function oneventreceived(receiver, info, origin) {
  if(info == "f\xdb\x8d\xba\xe6\xb2d\xd7o\xdc") {
    distsq = distancesquared(receiver.origin, origin);
    breakoutdist = 150;

    if(distsq < breakoutdist * breakoutdist) {
      self notify("\x01\xb3\xf0\xd2u\n*\xc8\xce\x16\x1a\xcc\x89?\x14\x0e");
      return true;
    }

    return true;
  }

  return false;
}

function setstationary(statename, params) {
  self setbtgoalstationary(1);
  self setbtgoalRadius(1, params[0]);
}

function usearmorplate(statename, params) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x01\xb3\xf0\xd2u\n*\xc8\xce\x16\x1a\xcc\x89?\x14\x0e");
  capname = "\xe7\x92\xbf\x14\xb5\xc5\xf2\x16\xc4\x04\x85\xdaG\x92Y\xdb\xd6\aa0\nW\xb8\xd5";

  if(self.asmname != capname) {
    cap::cap_start(capname, "\x8a\x11\x15K\\\x1f\x9b\xba\xfbZ\xf9\xc6\xc1K\f\xda}\xf5kByF\xc7\x7f\xd4\xb6\x13s\x8e\xfcr8d=hY\x10\xcd\xde\xaf0>");
  }

  tempdialogue(" v\vTBj_\x1d\xe0gSM\xad\x18*\x9c\xe8#");
  self waittill("\x9f{\x05H\xae\xach\xc8]\x19\xbe\xc09=\xfa\x1a\x9e\xd8");
  asm::asm_fireephemeralevent("\xeb\xc6$T\x9f$\xf6\xda\xa1\x9b\xda\xd3\xa9\xd9$", "8\xdb\x90");
}

function tempdialogue(var_df53eb41d04166e0) {
  debug = getdvarint(@ "hash_3e267ec6e066e2b", 0);

  if(istrue(debug)) {
    print3d(self.origin + (0, 0, 80), var_df53eb41d04166e0, (1, 1, 1), 1, 0.8, 1, 1);
  }
}