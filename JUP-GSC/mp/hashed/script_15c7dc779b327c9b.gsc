/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_15c7dc779b327c9b.gsc
*************************************************/

#using scripts\cp_mp\stealth\stealth_music;
#using scripts\engine\utility;
#using scripts\mp\utility\spawn_event_aggregator;
#namespace namespace_17ca84825c926284;

function init() {
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&scripts\cp_mp\stealth\stealth_music::function_9ff225017ef5ce19);
}