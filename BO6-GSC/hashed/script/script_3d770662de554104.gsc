/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_3d770662de554104.gsc
*****************************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\cap;
#using scripts\common\cap;
#namespace call_reinforcements;

function getfunction(funcid) {
  switch (funcid) {
    case #"hash_dab0d83df51da4d":
      return &onuserinit;
    case #"hash_722d767fd6d40f56":
      return &onuserterminate;
    case #"hash_256644959193a6c7":
      return &callreinforcements;
  }

  assertmsg("<dev string:x24>" + funcid);
}

function onuserinit(interactionid) {}

function onuserterminate(interactionid) {
  self clearbtgoal(1);
  self notify("\xfd\xdb8\x8f\xd5\x82\xa9\x9b\xba\xa1\x83\xd8\xb7\xb2\xb5\xf1\xf0\x85\xbc\xa1\xf0");
}

function callreinforcements(statename, params) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xfd\xdb8\x8f\xd5\x82\xa9\x9b\xba\xa1\x83\xd8\xb7\xb2\xb5\xf1\xf0\x85\xbc\xa1\xf0");
  callreinforcementsbundle = getscriptbundle("7\xd8\xe8$/\x88O\xfe\x82w\xe0\x878\x12lc\xcf\x15\a\b\xc2\xe0k\xec\xa8C\xcc/,Cp:\xd7\x19\xeb<,\xf8[\xfc\x80c\x90\x040\x17\xecC/\x94\xed0B\xb0g\xe2\xa6O\x9c.$F1\x8f\xe3h\n8l\xd8\x1b");

  if(!isDefined(callreinforcementsbundle)) {
    assertmsg("<dev string:x45>");
    return;
  }

  self setbtgoalstationary(1);
  self setbtgoalRadius(1, 12);
  capname = "\xfd\xc5x\xef\x7f\xffcv\x13/\xb6\xcf,\x1ev]\xda\xe4q\xf4\xad\x99\xe3";

  if(self.asmname != capname) {
    cap::cap_start(capname, "\xd0\x10\xe3\x9b\xc4\xaeR,t\x88\\\xa38\xbc\x86\x0etr\xd7\xb0EP:\x7f\x99\xfe\x98rQ\x88\xca{\x9ey\xdd\x02\x14`\xc5v\xb2");
  }

  self playSound("\xc0\x10\xdd\tg\x06\x1a\xdd\x95L\x12\xd3\xe2[\xa9G\f\xcd;\xe2w\b\xb3\x9e)");
  thread function_59a22dfd4278f41b(callreinforcementsbundle.var_1f7c5621a43eb4b4);
  self waittill("\x9f{\x05H\xae\xach\xc8]\x19\xbe\xc09=\xfa\x1a\x9e\xd8");
}

function function_59a22dfd4278f41b(calllength) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xfd\xdb8\x8f\xd5\x82\xa9\x9b\xba\xa1\x83\xd8\xb7\xb2\xb5\xf1\xf0\x85\xbc\xa1\xf0");
  wait calllength;

  if(isDefined(level.agent_funcs)) {
    spawnreinforcementsfunc = level.agent_funcs["\xde\x1f\xbd\x1c\x90\x0e\xa9\x0e\x90u^\x87T{\x8a\xbc^\x9e\x1eA"];

    if(isDefined(spawnreinforcementsfunc)) {
      [[spawnreinforcementsfunc]](self.origin, 0, 1);
    }
  }

  asm::asm_fireevent(self.asmname, "c\x16\x8dc_\xe4\xac\x96\xb9f{\x93\xd8\xca\xd6V\x9b:7\xfal{\xdb\x83\xfaY7\xc8");
}

function callreinforcementschooseanim(asmname, statename, params) {
  sectionname = params;

  if(!isDefined(sectionname)) {
    assertmsg("<dev string:xba>");
    return;
  }

  stance = asm_bb::bb_getrequestedstance();
  coverstate = asm_bb::bb_getrequestedcoverstate();
  animname = "\x0f'\xd4\xf2s\\\x91/>\xceg\xe2\x94n\xd0\xa0\xf4Y\xf6";

  if(coverstate != "\xff\xd5d'hTb") {
    covernode = asm_bb::bb_getcovernode();

    if(isDefined(covernode)) {
      covertype = covernode.type;

      switch (covertype) {
        case #"hash_cd3ffe799551db82":
          animname += "\x9e\xf5\r\xc5>\x98\xb3\x85*\xa3\xb9\a\x13" + stance;
          break;
        case #"hash_e1d8e1adebed5a61":
          animname += "\x93\xbe\x94Y\x93\xe0\xe6\xf5\xbd\x01.\x9a" + stance;
          break;
        case #"hash_c3b74422dec48736":
          animname += "\xb6\xd6\xdeY\xa2o!\xd5\xd2\x8dC\xdd\xa3";
          break;
        case #"hash_78b110033ccb68b0":
          animname += "\xf5\xcdW\\\xday$76\xcb\x8d\xfd";
          break;
      }
    }
  }

  animname += "w" + sectionname;
  alternativename = asm_cap::cap_lookupanimfromalias(statename, animname);
  return alternativename;
}