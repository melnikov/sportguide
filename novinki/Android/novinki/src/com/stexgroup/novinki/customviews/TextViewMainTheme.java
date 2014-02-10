package com.stexgroup.novinki.customviews;

import com.stexgroup.novinki.utils.TypefaceSingleton;

import android.content.Context;
import android.util.AttributeSet;
import android.widget.TextView;


/**
 * Created by admin on 7/24/13.
 */

public class TextViewMainTheme extends TextView {

    final static float LINE_SPACE_ADD = -3.0f;
    final static float LINE_SPACE_MULTI = 1.0f;

    public TextViewMainTheme(Context context) {
        super(context);
        this.setTypeface(TypefaceSingleton.getInstance(context).getFontRegular());
        setLineSpacing (LINE_SPACE_ADD, LINE_SPACE_MULTI);
    }

    public TextViewMainTheme(Context context, AttributeSet attrs) {
        super(context, attrs);
        try{
            this.setTypeface(TypefaceSingleton.getInstance(context).getFontRegular());

        }catch (Exception e)
        {
        	
        }
        setLineSpacing (LINE_SPACE_ADD, LINE_SPACE_MULTI);
    }

    public TextViewMainTheme(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        this.setTypeface(TypefaceSingleton.getInstance(context).getFontRegular());
        setLineSpacing (LINE_SPACE_ADD, LINE_SPACE_MULTI);
    }

}
