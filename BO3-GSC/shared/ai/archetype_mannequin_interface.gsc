/*******************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_mannequin_interface.gsc
*******************************************************/

#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\zombie;
#namespace mannequininterface;

function registermannequininterfaceattributes() {
  ai::registermatchedinterface("mannequin", "can_juke", 0, array(1, 0));
  ai::registermatchedinterface("mannequin", "suicidal_behavior", 0, array(1, 0));
  ai::registermatchedinterface("mannequin", "spark_behavior", 0, array(1, 0));
}