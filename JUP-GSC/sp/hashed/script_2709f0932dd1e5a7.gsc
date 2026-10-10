/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_2709f0932dd1e5a7.gsc
*************************************************/

#using scripts\cp\utility;
#using scripts\cp\utility\spawn_event_aggregator;
#using scripts\cp_mp\stealth\stealth_music;
#using scripts\engine\utility;
#namespace namespace_17e488825cae945a;

function init() {
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(&scripts\cp_mp\stealth\stealth_music::function_9ff225017ef5ce19);
}