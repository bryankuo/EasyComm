package com.apexx.bryan.easycomm;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.AdapterView;
import android.widget.GridView;
import android.widget.SimpleAdapter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class MainActivity extends AppCompatActivity {
    // how to import ( https://goo.gl/6s6wgm )
    private int[] image = {
            R.drawable.ic_action_doorphone, R.drawable.ic_action_package,
            R.drawable.ic_action_message, R.drawable.ic_action_bulltein1,
            R.drawable.ic_action_security
            // scrolling, more icon is possible
    };
    private String[] imgText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        imgText = getResources().getStringArray(R.array.func_entries); // ( https://goo.gl/z74Zov )

        // ( https://goo.gl/7sH5Vb )
        List<Map<String, Object>> items = new ArrayList<>();
        for (int i = 0; i < image.length; i++) {
            Map<String, Object> item = new HashMap<>();
            item.put("image", image[i]);
            item.put("text", imgText[i]);
            items.add(item);
        }
        SimpleAdapter adapter = new SimpleAdapter(this,
                items, R.layout.grid_item, new String[]{"image", "text"},
                new int[]{R.id.image, R.id.text});

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
                        .setAction("Action", null).show();
            }
        });
        GridView gridview =(GridView)findViewById(R.id.gridView);
        gridview.setNumColumns(2);
        gridview.setAdapter(adapter);
        gridview.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            public void onItemClick(AdapterView<?> parent, View v,
                                    int position, long id) {
                //Toast.makeText(MainActivity.this, "You select " + imgText[position], Toast.LENGTH_SHORT).show();
                if ( imgText[position].equalsIgnoreCase("security") ) {
                    startActivity(new Intent(MainActivity.this, NfcActivity.class));
                }
            }
        });
    }

}
