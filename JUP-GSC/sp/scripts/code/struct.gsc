/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\code\struct.gsc
***********************************************/



#namespace struct;

function initstructs() {
  level.struct = [];
}

function createstruct() {
  struct = spawnStruct();
  level.struct[level.struct.size] = struct;
  return struct;
}