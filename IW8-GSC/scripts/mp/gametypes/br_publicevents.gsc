
// Params 0
// Size: 0x8c
function init()
{
    if ( getdvarint( "scr_br_pe_disabled", 0 ) )
    {
        return;
    }
    
    level.delayeventfired = getdvarint( "scr_br_pe_grabbag", 0 ) == 1;
    level.delayedeventtypes = [];
    level.delay_thirdpersoncamera = [];
    level.delayedunsetbettermissionrewards = getdvarint( "scr_br_pe_event_repetition_buffer", 2 );
    level.delayedshowtablets = relic_squadlink_flash_squadlink_icon( "0 0 0 0 0 0 0 0" );
    level.´7ä¯Y}…ŽZì•×+õ·«æ£ = 0;
    all_players_within_distance2d();
    scripts\mp\gametypes\br_dev::ref_12b21( &setup_nuke_vault_door_open );
    
    if ( scripts\mp\gametypes\br_publicevents_meter::ispubliceventmeterenabled() )
    {
        level thread scripts\mp\gametypes\br_publicevents_meter::init();
    }
    
    if ( ref_12932() )
    {
        if ( unset_relic_healthpacks() )
        {
            thread ref_12934();
            return;
        }
        
        thread ref_12933();
        return;
    }
}

// Params 0
// Size: 0x7b
function all_players_within_distance2d()
{
    scripts\mp\gametypes\br_publicevent_bombardment::init();
    scripts\mp\gametypes\br_publicevent_choppers::init();
    scripts\mp\gametypes\br_publicevent_firesale::init();
    scripts\mp\gametypes\br_publicevent_jailbreak::init();
    scripts\mp\gametypes\br_publicevent_juggernaut::init();
    scripts\mp\gametypes\br_publicevent_restock::init();
    scripts\mp\gametypes\br_publicevent_satellite::init();
    scripts\mp\gametypes\br_publicevent_loadoutdrop::init();
    scripts\mp\gametypes\br_publicevent_lootcratedrop::init();
    scripts\mp\gametypes\br_publicevent_auavscan::init();
    scripts\mp\gametypes\br_publicevent_armoredtruck::init();
    scripts\mp\gametypes\br_publicevent_resurgence::init();
    scripts\mp\gametypes\br_publicevent_tower::init();
    scripts\mp\gametypes\br_publicevent_fresno::init();
    scripts\mp\gametypes\br_publicevent_interception_chopper::init();
    scripts\mp\gametypes\br_publicevent_fafir::init();
    scripts\mp\gametypes\br_publicevent_outbreak::init();
    
    if ( unset_relic_healthpacks() )
    {
        var0 = spawnstruct();
        var0.weight = 0;
        ref_12b35( 0, var0 );
    }
    
    _postinitevents();
}

// Params 0
// Size: 0x78
function _postinitevents()
{
    foreach ( var1 in level.delayedeventtypes )
    {
        if ( var1.weight <= 0 && !ispubliceventmeteractive( var1 ) )
        {
            continue;
        }
        
        if ( isdefined( var1.ref_140cf ) && ![[ var1.ref_140cf ]]() )
        {
            continue;
        }
        
        if ( isdefined( var1.‹Á¿ø{ÏXX;â# / ) )
        {
            var1 [[ var1.‹Á¿ø{ÏXX;â# / ]]();
        }
    }
}

// Params 2
// Size: 0x5e
function relic_squadlink_init_vfx( var0, var1 )
{
    var2 = getdvar( "scr_br_pe_" + var0 + "_circle_event_weights", var1 );
    var3 = [];
    
    if ( var2 != "" )
    {
        var4 = strtok( var2, " " );
        
        foreach ( var6 in var4 )
        {
            var3 = float( var6 );
        }
    }
    
    return var3;
}

// Params 1
// Size: 0x55
function relic_squadlink_flash_squadlink_icon( var0 )
{
    var1 = getdvar( "scr_br_pe_circle_event_chances", var0 );
    var2 = [];
    
    if ( var1 != "" )
    {
        var3 = strtok( var1, " " );
        
        foreach ( var5 in var3 )
        {
            var2 = float( var5 );
        }
    }
    
    return var2;
}

// Params 2
// Size: 0x6c
function ref_12b35( var0, var1 )
{
    if ( !isdefined( var1.weight ) )
    {
        var1.active = 0;
    }
    
    if ( !isdefined( var1.weight ) )
    {
        var1.weight = 1;
    }
    
    if ( unset_relic_healthpacks() )
    {
        if ( !isdefined( var1.ref_11b78 ) )
        {
            var1.ref_11b78 = 1;
        }
        
        if ( !isdefined( var1.compass ) )
        {
            var1.compass = [];
        }
    }
    
    level.delayedeventtypes[ var0 ] = var1;
    return var1;
}

// Params 0
// Size: 0x10
function generic_waittill_button_press()
{
    level notify( "cancel_public_event" );
    level.´7ä¯Y}…ŽZì•×+õ·«æ£ = 0;
}

// Params 0
// Size: 0x40, Type: bool
function ref_12932()
{
    var0 = getdvarint( "scr_br_pe_force_type", 0 );
    
    if ( var0 != 0 )
    {
        return true;
    }
    
    if ( scripts\mp\utility\game::updatex1stashhud() )
    {
        return false;
    }
    
    var1 = revive_wounded_out_handlerr();
    
    if ( !var1 )
    {
        return false;
    }
    
    var2 = revive_wounded_out_handler();
    
    if ( var2 <= 0 )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x55, Type: bool
function ref_132f7( var0 )
{
    var1 = revive_wounded_out_handler();
    
    if ( unset_relic_healthpacks() && isdefined( var0 ) )
    {
        if ( isdefined( level.delayedshowtablets[ var0 ] ) )
        {
            var1 = level.delayedshowtablets[ var0 ];
        }
        else
        {
            allsupportboxes( "Public event was not activated due to circle event chance not being set for circle " + var0 );
            return false;
        }
    }
    
    if ( var1 <= 0 )
    {
        return false;
    }
    
    return randomfloat( 1 ) <= var1;
}

// Params 0
// Size: 0xa, Type: bool
function isanypubliceventcurrentlyactive()
{
    return level.´7ä¯Y}…ŽZì•×+õ·«æ£ > 0;
}

// Params 0
// Size: 0xd
function revive_wounded_out_handlerr()
{
    return getdvarint( "scr_br_pe_count", 1 );
}

// Params 0
// Size: 0x10
function revive_wounded_out_handler()
{
    return getdvarfloat( "scr_br_pe_chance", 0 );
}

// Params 0
// Size: 0xd, Type: bool
function ref_11e05()
{
    var0 = revive_wounded_out_handlerr();
    return var0 != 1;
}

// Params 0
// Size: 0x71
function ref_12933()
{
    level endon( "cancel_public_event" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    if ( ref_11e05() )
    {
        var0 = getdvarfloat( "scr_br_pe_multi_wait_min", 240 );
        var1 = getdvarfloat( "scr_br_pe_multi_wait_max", 360 );
        
        for ( var2 = revive_wounded_out_handlerr(); var2 ; var2-- )
        {
            var3 = randomfloatrange( var0, var1 );
            wait var3;
            
            if ( ref_132f7() )
            {
                give_intel_data( 1 );
            }
        }
        
        return;
    }
    
    if ( ref_132f7() )
    {
        give_intel_data( 0 );
        return;
    }
}

// Params 0
// Size: 0x99
function ref_140cc()
{
    var0 = [];
    
    foreach ( var3, var2 in level.delayedeventtypes )
    {
        if ( var2.weight <= 0 )
        {
            allsupportboxes( ai_ignore_all_until_goal( var3 ) + " was invalidated due to 0 weight" );
            continue;
        }
        
        if ( isdefined( var2.ref_140cf ) && ![[ var2.ref_140cf ]]() )
        {
            allsupportboxes( ai_ignore_all_until_goal( var3 ) + " was invalidated due to failing validate function" );
            continue;
        }
        
        allsupportboxes( ai_ignore_all_until_goal( var3 ) + " was validated" );
        var0 = var3;
    }
    
    return var0;
}

// Params 3
// Size: 0x80
function safehouse_create_loot( var0, var1, var2 )
{
    var3 = 0;
    
    foreach ( var5 in var0 )
    {
        var6 = level.delayedeventtypes[ var5 ];
        var7 = var6.weight;
        var8 = scripts\engine\utility::ter_op( var2, var6.£¼#w]j‹ƒ½Ï‚UÀíÌI¸Û«, var6.guard_door_clip );
        
        if ( isdefined( var1 ) && isdefined( var8 ) && isdefined( var8[ var1 ] ) )
        {
            var7 = var8[ var1 ];
        }
        
        var3 += var7;
    }
    
    return var3;
}

// Params 4
// Size: 0x91
function play_sound_on_pa_systems( var0, var1, var2, var3 )
{
    var4 = 0;
    
    if ( !var0.size )
    {
        return 0;
    }
    
    foreach ( var6 in var0 )
    {
        var7 = level.delayedeventtypes[ var6 ];
        var8 = var7.weight;
        var9 = scripts\engine\utility::ter_op( var3, var7.£¼#w]j‹ƒ½Ï‚UÀíÌI¸Û«, var7.guard_door_clip );
        
        if ( isdefined( var2 ) && isdefined( var9 ) && isdefined( var9[ var2 ] ) )
        {
            var8 = var9[ var2 ];
        }
        
        var4 += var8;
        
        if ( var1 <= var4 )
        {
            return var6;
        }
    }
    
    return 0;
}

// Params 3
// Size: 0x9d
function give_intel_data( var0, var1, var2 )
{
    if ( !isdefined( var2 ) )
    {
        var2 = 0;
    }
    
    var3 = undefined;
    
    if ( unset_relic_healthpacks() )
    {
        allsupportboxes( "Selecting event for circle#: " + var1 );
        var3 = ref_140cd( var1, var2 );
    }
    else
    {
        var3 = ref_140cc();
    }
    
    if ( unset_relic_healthpacks() )
    {
    }
    
    var4 = safehouse_create_loot( var3, var1, var2 );
    var5 = randomfloat( var4 );
    var6 = play_sound_on_pa_systems( var3, var5, var1, var2 );
    allsupportboxes( "Selected event: " + ai_ignore_all_until_goal( var6 ) );
    var7 = getdvarint( "scr_br_pe_force_type", 0 );
    
    if ( var7 != 0 )
    {
        allsupportboxes( "Overriding selected event with: " + ai_ignore_all_until_goal( var7 ) );
        var6 = var7;
    }
    
    ref_12e1f( level, var6, var0, var1, var2 );
}

// Params 1
// Size: 0x3d
function activateevent( var0 )
{
    level endon( "game_ended" );
    level endon( "cancel_public_event" );
    
    if ( isdefined( var0.attackerswaittime ) )
    {
        var0 [[ var0.attackerswaittime ]]();
    }
    
    level.´7ä¯Y}…ŽZì•×+õ·«æ£ -= 1;
    level notify( "br_pe_end" );
}

// Params 4
// Size: 0x13d
function ref_12e1f( var0, var1, var2, var3 )
{
    level endon( "game_ended" );
    level endon( "cancel_public_event" );
    
    if ( var0 == 0 && !unset_relic_healthpacks() )
    {
        allsupportboxes( "No event was valid for this run." );
        return;
    }
    
    var4 = level.delayedeventtypes[ var0 ];
    
    if ( isdefined( var4.ref_14382 ) && !var1 )
    {
        var4 [[ var4.ref_14382 ]]();
    }
    
    if ( getdvarint( "scr_br_pe_enable_queueing", 1 ) > 0 )
    {
        while ( isanypubliceventcurrentlyactive() )
        {
            level scripts\engine\utility::ref_143a5( "br_pe_end", "cancel_public_event" );
            waitframe();
        }
    }
    
    level.´7ä¯Y}…ŽZì•×+õ·«æ£ += 1;
    var4.active = 1;
    scripts\mp\gametypes\br_analytics::devspectatetest( var0 );
    
    if ( unset_relic_healthpacks() )
    {
        level.delete_after_objective_a = 1;
        allsupportboxes( "Activating Event: " + ai_ignore_all_until_goal( var0 ) );
        thread activateevent( level );
        
        if ( !istrue( var3 ) )
        {
            if ( !isdefined( level.delete_bad_trucks[ var0 ] ) )
            {
                level.delete_bad_trucks[ var0 ] = 0;
            }
            
            level.delete_bad_trucks[ var0 ]++;
            
            if ( isdefined( var2 ) )
            {
                level.delay_vehicle_to_push_explode_sequence[ var0 ] = var2;
            }
        }
        
        var5 = level.delayedeventtypes[ var0 ].compass;
        activeparachuters( var5 );
        level waittill( "br_circle_set" );
        neurotoxin_mask_monitor( var0 );
        level notify( "select_new_event" );
        return;
    }
    
    activateevent( level, var4 );
    var4.active = 0;
    scripts\mp\gametypes\br_analytics::devspectateloc( var0 );
}

// Params 1
// Size: 0x3d
function neurotoxin_mask_monitor( var0 )
{
    if ( upload_station_interact_used_think( var0 ) )
    {
        var1 = level.delayedeventtypes[ var0 ];
        
        if ( isdefined( var1.isfeaturedisabled ) )
        {
            var1 [[ var1.isfeaturedisabled ]]();
        }
        
        var1.active = 0;
        scripts\mp\gametypes\br_analytics::devspectateloc( var0 );
        return;
    }
}

// Params 1
// Size: 0x1d, Type: bool
function upload_station_interact_used_think( var0 )
{
    var1 = level.delayedeventtypes[ var0 ];
    
    if ( !isdefined( var1 ) )
    {
        return false;
    }
    
    return istrue( var1.active );
}

// Params 1
// Size: 0x31
function ref_13371( var0 )
{
    foreach ( var2 in level.players )
    {
        var2 scripts\mp\hud_message::showsplash( var0 );
    }
}

// Params 2
// Size: 0xd
function dangercircletick( var0, var1 )
{
    scripts\mp\gametypes\br_publicevent_choppers::dangercircletick( var0, var1 );
}

// Params 1
// Size: 0x1c
function resetminimappulse( var0 )
{
    level endon( "game_ended" );
    
    if ( isdefined( var0 ) )
    {
        wait var0;
    }
    
    setomnvar( "ui_publicevent_minimap_pulse", 0 );
}

// Params 2
// Size: 0x5
function setup_nuke_vault_door_open( var0, var1 )
{
    
}

// Params 0
// Size: 0x9, Type: bool
function unset_relic_healthpacks()
{
    return istrue( level.delayeventfired );
}

// Params 0
// Size: 0x105
function ref_12934()
{
    level endon( "cancel_public_event" );
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    level.delete_bad_trucks = [];
    level.delay_vehicle_to_push_explode_sequence = [];
    var0 = 0;
    var1 = getdvarint( "scr_br_pe_max_event_count", level.br_level.br_circleradii.size - 1 );
    var2 = level.br_level.br_circleradii.size - 1;
    
    while ( var0 < var2 )
    {
        if ( var0 == 0 )
        {
            level waittill( "br_circle_set" );
            var3 = 5;
            var4 = getdvarint( "scr_br_pe_initial_delay", var3 );
            wait var4;
        }
        else
        {
            if ( istrue( level.delete_after_objective_a ) )
            {
                level waittill( "select_new_event" );
            }
            else
            {
                level waittill( "br_circle_set" );
            }
            
            var5 = 8;
            var6 = getdvarint( "scr_br_pe_subsequent_delay", var5 );
            wait var6;
        }
        
        if ( isdefined( level.£`Eò©øÅ+qrÃñkß+˜ÈK ) && level.£`Eò©øÅ+qrÃñkß+˜ÈK == 0 )
        {
            var7 = 0;
        }
        else
        {
            var7 = 1;
        }
        
        var8 = level.br_circle.circleindex;
        
        if ( ref_132f7( var8 ) )
        {
            thread give_intel_data( level, var7, var8 );
        }
        else
        {
            level.delete_after_objective_a = 0;
        }
        
        var0++;
    }
}

// Params 2
// Size: 0x262
function ref_140cd( var0, var1 )
{
    var2 = [];
    
    foreach ( var11, var4 in level.delayedeventtypes )
    {
        if ( var4.weight <= 0 )
        {
            allsupportboxes( ai_ignore_all_until_goal( var11 ) + " was invalidated due to 0 weight" );
            continue;
        }
        
        if ( isdefined( var4.ref_140cf ) && ![[ var4.ref_140cf ]]() )
        {
            allsupportboxes( ai_ignore_all_until_goal( var11 ) + " was invalidated due to failing validate function" );
            continue;
        }
        
        if ( isdefined( level.delay_thirdpersoncamera ) && istrue( level.delay_thirdpersoncamera[ var11 ] ) )
        {
            allsupportboxes( ai_ignore_all_until_goal( var11 ) + " was invalidated due to this event being on the blacklist" );
            continue;
        }
        
        if ( isdefined( var4.compass ) )
        {
            var5 = 0;
            
            foreach ( var7 in var4.compass )
            {
                if ( isdefined( level.delete_bad_trucks[ var7 ] ) )
                {
                    if ( level.delete_bad_trucks[ var7 ] > 0 )
                    {
                        var5 = 1;
                        break;
                    }
                }
            }
            
            if ( var5 )
            {
                allsupportboxes( ai_ignore_all_until_goal( var11 ) + " was invalidated due to a previously run event to being on this event's blacklist" );
                continue;
            }
        }
        
        var9 = scripts\engine\utility::ter_op( var1, var4.£¼#w]j‹ƒ½Ï‚UÀíÌI¸Û«, var4.guard_door_clip );
        
        if ( isdefined( var9 ) )
        {
            if ( isdefined( var9[ var0 ] ) && var9[ var0 ] <= 0 )
            {
                allsupportboxes( ai_ignore_all_until_goal( var11 ) + " was invalidated due to 0 weight" );
                continue;
            }
            else if ( !isdefined( var9[ var0 ] ) )
            {
                allsupportboxes( ai_ignore_all_until_goal( var11 ) + " was invalidated due to missing circle event weight for circle" + var0 );
                continue;
            }
        }
        
        if ( !istrue( var1 ) )
        {
            if ( isdefined( level.delete_bad_trucks ) && isdefined( level.delete_bad_trucks[ var11 ] ) )
            {
                if ( isdefined( var4.ref_11b78 ) && level.delete_bad_trucks[ var11 ] >= var4.ref_11b78 )
                {
                    allsupportboxes( ai_ignore_all_until_goal( var11 ) + " was invalidated due to already activating max times" );
                    continue;
                }
            }
            
            if ( isdefined( level.delay_vehicle_to_push_explode_sequence ) && isdefined( level.delay_vehicle_to_push_explode_sequence[ var11 ] ) )
            {
                var10 = var0 - level.delay_vehicle_to_push_explode_sequence[ var11 ];
                
                if ( var10 >= level.delayedunsetbettermissionrewards + 1 )
                {
                    level.delay_vehicle_to_push_explode_sequence[ var11 ] = undefined;
                }
                else
                {
                    allsupportboxes( ai_ignore_all_until_goal( var11 ) + " was invalidated due to being a previously ran event within the span of the event repetition buffer." );
                    continue;
                }
            }
        }
        
        allsupportboxes( ai_ignore_all_until_goal( var11 ) + " was validated" );
        var2 = var11;
    }
    
    if ( var2.size == 0 )
    {
        var2 = 0;
    }
    
    return var2;
}

// Params 1
// Size: 0x1f
function allsupportboxes( var0 )
{
    if ( getdvarint( "scr_br_pe_debug", 0 ) == 1 )
    {
        logstring( "PE: " + var0 );
        return;
    }
}

// Params 1
// Size: 0x138
function ai_ignore_all_until_goal( var0 )
{
    switch ( var0 )
    {
        case 0:
            return "CONST_BR_PE_TYPE_NONE";
        case 1:
            return "CONST_BR_PE_TYPE_CHOPPERS";
        case 2:
            return "CONST_BR_PE_TYPE_FIRESALE";
        case 3:
            return "CONST_BR_PE_TYPE_JAILBREAK";
        case 4:
            return "CONST_BR_PE_TYPE_JUGGERNAUT";
        case 5:
            return "CONST_BR_PE_TYPE_BOMBARDMENT";
        case 6:
            return "CONST_BR_PE_TYPE_RESTOCK";
        case 7:
            return "CONST_BR_PE_TYPE_SATELLITE";
        case 8:
            return "CONST_BR_PE_TYPE_LOADOUTDROP";
        case 9:
            return "CONST_BR_PE_TYPE_LOOTCRATE_DROP";
        case 10:
            return "CONST_BR_PE_TYPE_AUAVSCAN";
        case 11:
            return "CONST_BR_PE_TYPE_ARMOREDTRUCK";
        case 12:
            return "CONST_BR_PE_TYPE_PLUNDER_CRATE_DROP";
        case 13:
            return "CONST_BR_PE_TYPE_WEAPON_CRATE_DROP";
        case 20:
            return "CONST_BR_PE_TYPE_MEDICAL_CRATE_DROP";
        case 14:
            return "CONST_BR_PE_TYPE_RESURGENCE";
        case 15:
            return "CONST_BR_PE_TYPE_TOWER";
        case 16:
            return "CONST_BR_PE_TYPE_FRESNO";
        case 17:
            return "CONST_BR_PE_TYPE_INTERCEPTION";
        case 18:
            return "CONST_BR_PE_TYPE_FAFIR";
        case 19:
            return "CONST_BR_PE_TYPE_OUTBREAK";
        default:
            scripts\mp\utility\script::laststand_dogtags( "No name is defined for eventType: " + var0 );
            return "UNKNOWN_TYPE";
    }
}

// Params 1
// Size: 0x3a
function activeparachuters( var0 )
{
    foreach ( var2 in var0 )
    {
        if ( !isdefined( level.delay_thirdpersoncamera[ var2 ] ) )
        {
            level.delay_thirdpersoncamera[ var2 ] = 1;
        }
    }
}

// Params 1
// Size: 0x43, Type: bool
function ispubliceventmeteractive( var0 )
{
    if ( isdefined( var0.£¼#w]j‹ƒ½Ï‚UÀíÌI¸Û« ) )
    {
        foreach ( var2 in var0.£¼#w]j‹ƒ½Ï‚UÀíÌI¸Û« )
        {
            if ( var2 > 0 )
            {
                return true;
            }
        }
    }
    
    return false;
}

