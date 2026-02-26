/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_jungle_rm.gsc
***********************************************/

#using scripts\core_common\compass;
#using scripts\core_common\load_shared;
#using scripts\mp\mp_jungle_rm_scripted;
#namespace mp_jungle_rm;

function event_handler[level_init] main(eventstruct) {
  level.var_3f67dcdf[#"hash_9427ab408a6d728"] = 1;
  level.var_3f67dcdf[#"hash_68cfe8859ffe368f"] = 1;
  load::main();
  compass::setupminimap("");
  level.cleandepositpoints = array((1820.25, 87.5, 88.25), (2648.75, -1356, 270), (-86.75, -514.5, 264), (438.75, -1640.75, 124), (458.25, 1278.5, 239));
}