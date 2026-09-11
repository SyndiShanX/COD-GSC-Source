
// Params 5
// Size: 0x5f
function registertutorialprogressnotifystate( var0, var1, var2, var3, var4 )
{
    if ( !isdefined( self.‘ä8NŞ'¬n›Üè,:Yæ ) )
    {
        self.‘ä8NŞ'¬n›Üè,:Yæ = [];
        self.ºñÁNÛÙœ²æn–æŒ¬ = 0;
    }
    
    var5 = spawnstruct();
    var5.notifyentity = var0;
    var5.notifyname = var1;
    var5.ˆeKØ—Ÿ‹‘C]'™ã;Ğƒ"¨ = var2;
    var5.†R¢8ñÀÃÈú0;p = var3;
    var5.b
˜zeKo¤ám = var4;
    self.‘ä8NŞ'¬n›Üè,:Yæ[ self.‘ä8NŞ'¬n›Üè,:Yæ.size ] = var5;
    return var5;
}

// Params 4
// Size: 0x30
function registertutorialprogresstriggerstate( var0, var1, var2, var3 )
{
    var4 = scripts\engine\utility::getent_or_struct( var0, "targetname" );
    var5 = registertutorialprogressnotifystate( var4, "trigger", var1, var2, var3 );
    var5.¸ş·f‰Ó»¬XĞ†PÄ HÓ€ñâWÎ = &conditionaltriggerhandler;
}

// Params 1
// Size: 0x31
function conditionaltriggerhandler( var0 )
{
    for ( ;; )
    {
        var0.notifyentity waittill( var0.notifyname, var1 );
        
        if ( isbot( var1 ) )
        {
            continue;
        }
        
        break;
    }
}

// Params 0
// Size: 0xdb
function tutorialprogress()
{
    self.¡:Û+g:í¸š;~¶¥Ëû	.ÕP2õ = getsystemtime();
    level scripts\common\ui::lui_registercallback( "end_game", &tutorialonendgame );
    
    for ( ;; )
    {
        if ( self.ºñÁNÛÙœ²æn–æŒ¬ >= self.‘ä8NŞ'¬n›Üè,:Yæ.size )
        {
            return;
        }
        
        var0 = self.‘ä8NŞ'¬n›Üè,:Yæ[ self.ºñÁNÛÙœ²æn–æŒ¬ ];
        
        if ( isdefined( var0.notifyentity ) && isdefined( var0.notifyname ) )
        {
            if ( isdefined( var0.ˆeKØ—Ÿ‹‘C]'™ã;Ğƒ"¨ ) )
            {
                thread progressupdatethreadwrapper( var0.notifyentity, var0.notifyname, var0.ˆeKØ—Ÿ‹‘C]'™ã;Ğƒ"¨ );
            }
            
            if ( isdefined( var0.¸ş·f‰Ó»¬XĞ†PÄ HÓ€ñâWÎ ) )
            {
                self [[ var0.¸ş·f‰Ó»¬XĞ†PÄ HÓ€ñâWÎ ]]( var0 );
            }
            else
            {
                var0.notifyentity waittill( var0.notifyname );
            }
        }
        else
        {
            waitframe();
            self.ºñÁNÛÙœ²æn–æŒ¬++;
            continue;
        }
        
        tutorialrecordprogress( 0 );
        
        if ( isdefined( var0.†R¢8ñÀÃÈú0;p ) )
        {
            self [[ var0.†R¢8ñÀÃÈú0;p ]]();
        }
        
        waitframe();
        self.ºñÁNÛÙœ²æn–æŒ¬++;
    }
}

// Params 1
// Size: 0x54
function tutorialrecordprogress( var0 )
{
    var1 = getsystemtime();
    var2 = var1 - self.¡:Û+g:í¸š;~¶¥Ëû	.ÕP2õ;
    var3 = self.‘ä8NŞ'¬n›Üè,:Yæ[ self.ºñÁNÛÙœ²æn–æŒ¬ ];
    level.players[ 0 ] dlog_recordplayerevent( "dlog_event_tutorial_progress", [ "state", var3.b
˜zeKo¤ám, "duration_s", var2, "end_game", var0 ] );
    self.¡:Û+g:í¸š;~¶¥Ëû	.ÕP2õ = var1;
}

// Params 1
// Size: 0x38
function tutorialonendgame( var0 )
{
    if ( isdefined( level.¡:Û+g:í¸š;~¶¥Ëû	.ÕP2õ ) && isdefined( level.ºñÁNÛÙœ²æn–æŒ¬ ) && isdefined( level.‘ä8NŞ'¬n›Üè,:Yæ ) && level.ºñÁNÛÙœ²æn–æŒ¬ < level.‘ä8NŞ'¬n›Üè,:Yæ.size )
    {
        tutorialrecordprogress( level, 1 );
        return;
    }
}

// Params 3
// Size: 0xe
function progressupdatethreadwrapper( var0, var1, var2 )
{
    var0 endon( var1 );
    self [[ var2 ]]();
}

// Params 0
// Size: 0x2
function tutorialprogressdebug()
{
    
}

// Params 2
// Size: 0x5
function tutorialprogressdebugsinglestate( var0, var1 )
{
    
}

