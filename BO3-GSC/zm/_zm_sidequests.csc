/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_sidequests.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#namespace zm_sidequests;

function register_sidequest_icon(icon_name, version_number) {
  clientfieldprefix = ("sidequestIcons." + icon_name) + ".";
  clientfield::register("clientuimodel", clientfieldprefix + "icon", version_number, 1, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", clientfieldprefix + "notification", version_number, 1, "int", undefined, 0, 0);
}