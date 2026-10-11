/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\tripwire_mp.gsc
***********************************************/

#using scripts\engine\utility;
#using scripts\mp\pmc_missions;
#using scripts\mp\poi;
#using scripts\mp\utility\points;
#namespace tripwire_mp;

function ontripwirecreate(tripwire) {
  tripwire.poi = scripts\mp\poi::poi_findpoioriginisin(tripwire.origin);
}

function ontripwiretriggered(player, tripwire) {
  scripts\mp\pmc_missions::function_800f75fe5e5c7462(player, tripwire);
}

function ontripwiredefused(player, tripwire) {
  player thread scripts\mp\utility\points::doscoreevent(#"hash_8ebedeb366a503f7");
}