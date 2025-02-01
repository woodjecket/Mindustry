package mindustryX.events;

import arc.*;
import arc.graphics.*;
import arc.util.*;
import mindustry.content.*;
import mindustry.entities.*;
import mindustry.gen.*;
import mindustry.graphics.*;
import mindustryX.*;

/**
 * @author minri2
 * Create by 2025/1/31
 */
public class HealthChangedEvent{
    public static final HealthChangedEvent INSTANCE = new HealthChangedEvent();

    public Healthc entity;
    public @Nullable Entityc source;
    public boolean isSplash = false;
    public float amount;

    public static void fire(Healthc entity, float amount){
        INSTANCE.entity = entity;
        INSTANCE.amount = amount;
        Events.fire(INSTANCE);
        INSTANCE.entity = null;
        INSTANCE.source = null;
    }
}
