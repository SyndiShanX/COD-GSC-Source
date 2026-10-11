/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_5cecb9996007959.gsc
************************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_bb;
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

  assertmsg("Missing function pointer for " + funcid);
}

function onuserinit(interactionid) {}

function onuserterminate(interactionid) {
  self clearbtgoal(1);
  self notify("endusearmorplate");

  if(isagent(self)) {
    assertex(self isscriptable(), "<dev string:x1c>" + self.agent_type + "<dev string:x29>");
  }

  scriptablepart = "armor_plate";

  if(self isscriptable() && self getscriptablehaspart(scriptablepart)) {
    self setscriptablepartstate(scriptablepart, "default");
  }

  if(isalive(self) && self.asmname == "cap_use_armor_plate_solo") {
    scripts\common\cap::cap_exit();
  }
}

function oneventreceived(receiver, info, origin) {
  if(info == "focused_on") {
    distsq = distancesquared(receiver.origin, origin);
    breakoutdist = 150;

    if(distsq < breakoutdist * breakoutdist) {
      self notify("endusearmorplate");
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
  self endon("death");
  self endon("endusearmorplate");
  capname = "cap_use_armor_plate_solo";

  if(self.asmname != capname) {
    scripts\common\cap::cap_start(capname, "caps/interactions/cap_use_armor_plate_solo");
  }

  tempdialogue("Using Armor Plate!");
  self waittill("cap_exit_completed");
  asm_fireephemeralevent("use_armor_plate", "end");
}

function tempdialogue(var_22e9090a351646e9) {
  debug = getdvarint(@ "hash_3e267ec6e066e2b", 0);

  if(istrue(debug)) {
    print3d(self.origin + (0, 0, 80), var_22e9090a351646e9, (1, 1, 1), 1, 0.8, 1, 1);
  }
}