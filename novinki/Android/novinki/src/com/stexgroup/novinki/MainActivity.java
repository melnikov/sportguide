package com.stexgroup.novinki;

import com.stexgroup.novinki.customviews.ActionItem;
import com.stexgroup.novinki.customviews.QuickAction;

import android.os.Bundle;
import android.app.Activity;
import android.content.Intent;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;

public class MainActivity extends Activity implements OnClickListener {

	
	private QuickAction quickActionPrice;
	private QuickAction quickActionContacts;
	
	//action id
    private static final int ID_PRICE_1     = 1;
    private static final int ID_PRICE_2   	= 2;
    private static final int ID_PRICE_3 	= 3;
    private static final int ID_PRICE_4   	= 4;
    private static final int ID_PRICE_5  	= 5; 
    private static final int ID_PRICE_6     = 6;
    private static final int ID_PRICE_7     = 7;
    private static final int ID_PRICE_8     = 8;
    
    private static final int ID_CONTACTS_1     = 10;
    private static final int ID_CONTACTS_2     = 11;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_splash);
		findViewById(R.id.linear_layout_working_time).setOnClickListener(this);
		findViewById(R.id.linear_layout_contacts).setOnClickListener(this);
		findViewById(R.id.linear_layout_price).setOnClickListener(this);
		findViewById(R.id.linear_layout_weather).setOnClickListener(this);
		findViewById(R.id.linear_layout_photo).setOnClickListener(this);
		findViewById(R.id.image_view_dude_btn).setOnClickListener(this);
		initPriceMenu();
		initContactsMenu();
	}

	@Override
	public void onClick(View v) {
		switch (v.getId()) {
		case R.id.linear_layout_working_time:
			startActivity(new Intent(MainActivity.this, WorkingTimeActivity.class));
			break;
		case R.id.linear_layout_contacts:
			showContactsMenu(v);
			break;
		case R.id.linear_layout_price:
			showPriceMenu(v);
			break;
		case R.id.linear_layout_weather:
			startActivity(new Intent(MainActivity.this, WheaterActivity.class));
			break;
		case R.id.linear_layout_photo:
			
			break;
		case R.id.image_view_dude_btn:
			startActivity(new Intent(MainActivity.this, AboutActivity.class));
			break;
		default:
			break;
		}
	}

	private void showPriceMenu(View v) {
		quickActionPrice.show(v);
	}
	
	private void showContactsMenu(View v) {
		quickActionContacts.show(v);
	}
	
	private void initPriceMenu(){
		ActionItem price_sub_1     	= new ActionItem(ID_PRICE_1, getString(R.string.price_sub_1));
        ActionItem price_sub_2    	= new ActionItem(ID_PRICE_2, getString(R.string.price_sub_2));
        ActionItem price_sub_3  	= new ActionItem(ID_PRICE_3, getString(R.string.price_sub_3));
        ActionItem price_sub_4     	= new ActionItem(ID_PRICE_4, getString(R.string.price_sub_4));
        ActionItem price_sub_5    	= new ActionItem(ID_PRICE_5, getString(R.string.price_sub_5));
        ActionItem price_sub_6      = new ActionItem(ID_PRICE_6, getString(R.string.price_sub_6));
        ActionItem price_sub_7      = new ActionItem(ID_PRICE_7, getString(R.string.price_sub_7));
        ActionItem price_sub_8      = new ActionItem(ID_PRICE_8, getString(R.string.price_sub_8));


        //create QuickAction. Use QuickAction.VERTICAL or QuickAction.HORIZONTAL param to define layout 
        //orientation
        quickActionPrice = new QuickAction(this, QuickAction.VERTICAL);

        //add action items into QuickAction
        quickActionPrice.addActionItem(price_sub_1);
        quickActionPrice.addActionItem(price_sub_2);
        quickActionPrice.addActionItem(price_sub_3);
        quickActionPrice.addActionItem(price_sub_4);
        quickActionPrice.addActionItem(price_sub_5);
        quickActionPrice.addActionItem(price_sub_6);
        quickActionPrice.addActionItem(price_sub_7);
        quickActionPrice.addActionItem(price_sub_8);

        //Set listener for action item clicked
        quickActionPrice.setOnActionItemClickListener(new QuickAction.OnActionItemClickListener() {          
            @Override
            public void onItemClick(QuickAction source, int pos, int actionId) {
                //here we can filter which action item was clicked with pos or actionId parameter
                ActionItem actionItem = quickActionPrice.getActionItem(pos);
                
                int layoutId = R.layout.activity_price_podem;
                
                switch (actionId) {
				case ID_PRICE_1:
					layoutId = R.layout.activity_price_podem;
					break;
				case ID_PRICE_2:
					layoutId = R.layout.activity_price_procat;
					break;
				case ID_PRICE_3:
					layoutId = R.layout.activity_price_snow_tubing;
					break;
				case ID_PRICE_4:
					layoutId = R.layout.activity_price_trainig;
					break;
				case ID_PRICE_5:
					layoutId = R.layout.activity_price_sky_service;
					break;
				case ID_PRICE_6:
					layoutId = R.layout.activity_price_hourse;
					break;
				case ID_PRICE_7:
					layoutId = R.layout.activity_price_bar;
					break;
				case ID_PRICE_8:
					layoutId = R.layout.activity_price_hotel;
					break;
				default:
					break;
				}
                
                startActivity(new Intent(MainActivity.this, PriceDetailsActivity.class).
						putExtra(PriceDetailsActivity.TYPE_VIEW, layoutId));
            }
        });
	}
	
	private void initContactsMenu(){
		ActionItem price_sub_1     	= new ActionItem(ID_CONTACTS_1, getString(R.string.contacts_sub_1));
        ActionItem price_sub_2    	= new ActionItem(ID_CONTACTS_2, getString(R.string.contacts_sub_2));

        quickActionContacts = new QuickAction(this, QuickAction.VERTICAL);

        //add action items into QuickAction
        quickActionContacts.addActionItem(price_sub_1);
        quickActionContacts.addActionItem(price_sub_2);
        

        //Set listener for action item clicked
        quickActionContacts.setOnActionItemClickListener(new QuickAction.OnActionItemClickListener() {          
            @Override
            public void onItemClick(QuickAction source, int pos, int actionId) {
                //here we can filter which action item was clicked with pos or actionId parameter
                switch (actionId) {
				case ID_CONTACTS_1:
					startActivity(new Intent(MainActivity.this, MapDirectionActivity.class));
					break;
				case ID_CONTACTS_2:
					startActivity(new Intent(MainActivity.this, MapComplexActivity.class));
					break;
				default:
					break;
				}

            }
        });
	}

}
