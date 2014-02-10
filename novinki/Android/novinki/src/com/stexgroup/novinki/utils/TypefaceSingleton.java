package com.stexgroup.novinki.utils;

import android.content.Context;
import android.graphics.Typeface;

public class TypefaceSingleton {

	private Typeface mGothic = null;
	private Typeface mGothicB = null;
	private Typeface mGothicBI = null;
	private Typeface mGothicI = null;

	private static TypefaceSingleton instance = null;

	private TypefaceSingleton(Context context) {
		mGothic = Typeface.createFromAsset(context.getResources()
				.getAssets(), "GOTHIC.TTF");
		mGothicB = Typeface.createFromAsset(context.getResources()
				.getAssets(), "GOTHICB.TTF");
		mGothicBI = Typeface.createFromAsset(context.getResources()
				.getAssets(), "GOTHICBI.TTF");
		mGothicI = Typeface.createFromAsset(context.getResources()
				.getAssets(), "GOTHICI.TTF");
	}

	public static TypefaceSingleton getInstance(Context context) {
		
		if (instance == null) {
			instance = new TypefaceSingleton(context);
		}
		return instance;
	}

    public Typeface getFontRegular() {
        return mGothic;
    }
    
    public Typeface getFontBold() {
        return mGothicB;
    }
    
    public Typeface getFontBoldItalic() {
        return mGothicBI;
    }
    
    public Typeface getFontItalic() {
        return mGothicI;
    }
}
