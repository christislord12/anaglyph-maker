// _AnaglyphDocument_EOArchive_English.java
// Generated by EnterpriseObjects palette at Sunday, February 8, 2004 7:42:18 PM America/New_York

import com.webobjects.eoapplication.*;
import com.webobjects.eocontrol.*;
import com.webobjects.eointerface.*;
import com.webobjects.eointerface.swing.*;
import com.webobjects.foundation.*;
import java.awt.*;
import javax.swing.*;
import javax.swing.border.*;
import javax.swing.table.*;
import javax.swing.text.*;

public class _AnaglyphDocument_EOArchive_English extends com.webobjects.eoapplication.EOArchive {
    AnaglyphController _anaglyphController0;
    com.webobjects.eointerface.swing.EOFrame _eoFrame0;
    com.webobjects.eointerface.swing.EOImageView _nsImageView0, _nsImageView1, _nsImageView2;
    com.webobjects.eointerface.swing.EOMatrix _nsMatrix0;
    com.webobjects.eointerface.swing.EOView _nsBox0, _nsBox1, _nsBox2, _nsBox3, _nsProgressIndicator0;
    javax.swing.JButton _nsButton0, _nsButton1, _nsButton2, _nsButton3, _nsButton4;
    javax.swing.JPanel _nsView0;
    javax.swing.JRadioButton _jRadioButton0, _jRadioButton1;

    public _AnaglyphDocument_EOArchive_English(Object owner, NSDisposableRegistry registry) {
        super(owner, registry);
    }

    protected void _construct() {
        Object owner = _owner();
        EOArchive._ObjectInstantiationDelegate delegate = (owner instanceof EOArchive._ObjectInstantiationDelegate) ? (EOArchive._ObjectInstantiationDelegate)owner : null;
        Object replacement;

        super._construct();

        _nsBox3 = (com.webobjects.eointerface.swing.EOView)_registered(new com.webobjects.eointerface.swing.EOView(), "");
        _nsBox2 = (com.webobjects.eointerface.swing.EOView)_registered(new com.webobjects.eointerface.swing.EOView(), "");
        _nsBox1 = (com.webobjects.eointerface.swing.EOView)_registered(new com.webobjects.eointerface.swing.EOView(), "");
        _nsBox0 = (com.webobjects.eointerface.swing.EOView)_registered(new com.webobjects.eointerface.swing.EOView(), "");

        if ((delegate != null) && ((replacement = delegate.objectForOutletPath(this, "controller.exportButton")) != null)) {
            _nsButton4 = (replacement == EOArchive._ObjectInstantiationDelegate.NullObject) ? null : (javax.swing.JButton)replacement;
            _replacedObjects.setObjectForKey(replacement, "_nsButton4");
        } else {
            _nsButton4 = (javax.swing.JButton)_registered(new javax.swing.JButton("Export"), "NSButton");
        }

        if ((delegate != null) && ((replacement = delegate.objectForOutletPath(this, "controller.clearRightImageButton")) != null)) {
            _nsButton3 = (replacement == EOArchive._ObjectInstantiationDelegate.NullObject) ? null : (javax.swing.JButton)replacement;
            _replacedObjects.setObjectForKey(replacement, "_nsButton3");
        } else {
            _nsButton3 = (javax.swing.JButton)_registered(new javax.swing.JButton("Clear"), "NSButton11");
        }

        if ((delegate != null) && ((replacement = delegate.objectForOutletPath(this, "controller.clearLeftImageButton")) != null)) {
            _nsButton2 = (replacement == EOArchive._ObjectInstantiationDelegate.NullObject) ? null : (javax.swing.JButton)replacement;
            _replacedObjects.setObjectForKey(replacement, "_nsButton2");
        } else {
            _nsButton2 = (javax.swing.JButton)_registered(new javax.swing.JButton("Clear"), "NSButton1");
        }

        if ((delegate != null) && ((replacement = delegate.objectForOutletPath(this, "controller.loadRightImageButton")) != null)) {
            _nsButton1 = (replacement == EOArchive._ObjectInstantiationDelegate.NullObject) ? null : (javax.swing.JButton)replacement;
            _replacedObjects.setObjectForKey(replacement, "_nsButton1");
        } else {
            _nsButton1 = (javax.swing.JButton)_registered(new javax.swing.JButton("Load"), "NSButton2");
        }

        if ((delegate != null) && ((replacement = delegate.objectForOutletPath(this, "controller.loadLeftImageButton")) != null)) {
            _nsButton0 = (replacement == EOArchive._ObjectInstantiationDelegate.NullObject) ? null : (javax.swing.JButton)replacement;
            _replacedObjects.setObjectForKey(replacement, "_nsButton0");
        } else {
            _nsButton0 = (javax.swing.JButton)_registered(new javax.swing.JButton("Load"), "NSButton");
        }

        _jRadioButton1 = (javax.swing.JRadioButton)_registered(new javax.swing.JRadioButton("Color"), "NSButtonCell1");
        _jRadioButton0 = (javax.swing.JRadioButton)_registered(new javax.swing.JRadioButton("Grayscale"), "NSButtonCell");

        if ((delegate != null) && ((replacement = delegate.objectForOutletPath(this, "controller.colorModeRadioButtons")) != null)) {
            _nsMatrix0 = (replacement == EOArchive._ObjectInstantiationDelegate.NullObject) ? null : (com.webobjects.eointerface.swing.EOMatrix)replacement;
            _replacedObjects.setObjectForKey(replacement, "_nsMatrix0");
        } else {
            _nsMatrix0 = (com.webobjects.eointerface.swing.EOMatrix)_registered(new com.webobjects.eointerface.swing.EOMatrix(2, 1, 4, 2), "NSMatrix1");
        }

        if ((delegate != null) && ((replacement = delegate.objectForOutletPath(this, "controller.processingSpinner")) != null)) {
            _nsProgressIndicator0 = (replacement == EOArchive._ObjectInstantiationDelegate.NullObject) ? null : (com.webobjects.eointerface.swing.EOView)replacement;
            _replacedObjects.setObjectForKey(replacement, "_nsProgressIndicator0");
        } else {
            _nsProgressIndicator0 = (com.webobjects.eointerface.swing.EOView)_registered(new com.webobjects.eointerface.swing.EOView(), "11");
        }

        if ((delegate != null) && ((replacement = delegate.objectForOutletPath(this, "controller.rightImage")) != null)) {
            _nsImageView2 = (replacement == EOArchive._ObjectInstantiationDelegate.NullObject) ? null : (com.webobjects.eointerface.swing.EOImageView)replacement;
            _replacedObjects.setObjectForKey(replacement, "_nsImageView2");
        } else {
            _nsImageView2 = (com.webobjects.eointerface.swing.EOImageView)_registered(new com.webobjects.eointerface.swing.EOImageView(), "");
        }

        if ((delegate != null) && ((replacement = delegate.objectForOutletPath(this, "controller.leftImage")) != null)) {
            _nsImageView1 = (replacement == EOArchive._ObjectInstantiationDelegate.NullObject) ? null : (com.webobjects.eointerface.swing.EOImageView)replacement;
            _replacedObjects.setObjectForKey(replacement, "_nsImageView1");
        } else {
            _nsImageView1 = (com.webobjects.eointerface.swing.EOImageView)_registered(new com.webobjects.eointerface.swing.EOImageView(), "");
        }

        if ((delegate != null) && ((replacement = delegate.objectForOutletPath(this, "controller")) != null)) {
            _anaglyphController0 = (replacement == EOArchive._ObjectInstantiationDelegate.NullObject) ? null : (AnaglyphController)replacement;
            _replacedObjects.setObjectForKey(replacement, "_anaglyphController0");
        } else {
            _anaglyphController0 = (AnaglyphController)_registered(new AnaglyphController(), "AnaglyphController");
        }

        if ((delegate != null) && ((replacement = delegate.objectForOutletPath(this, "controller.finalImage")) != null)) {
            _nsImageView0 = (replacement == EOArchive._ObjectInstantiationDelegate.NullObject) ? null : (com.webobjects.eointerface.swing.EOImageView)replacement;
            _replacedObjects.setObjectForKey(replacement, "_nsImageView0");
        } else {
            _nsImageView0 = (com.webobjects.eointerface.swing.EOImageView)_registered(new com.webobjects.eointerface.swing.EOImageView(), "");
        }

        if ((delegate != null) && ((replacement = delegate.objectForOutletPath(this, "controller.window")) != null)) {
            _eoFrame0 = (replacement == EOArchive._ObjectInstantiationDelegate.NullObject) ? null : (com.webobjects.eointerface.swing.EOFrame)replacement;
            _replacedObjects.setObjectForKey(replacement, "_eoFrame0");
        } else {
            _eoFrame0 = (com.webobjects.eointerface.swing.EOFrame)_registered(new com.webobjects.eointerface.swing.EOFrame(), "Window");
        }

        _nsView0 = (JPanel)_eoFrame0.getContentPane();
    }

    protected void _awaken() {
        super._awaken();

        if (_replacedObjects.objectForKey("_eoFrame0") == null) {
            _connect(_eoFrame0, _owner(), "delegate");
        }

        if (_replacedObjects.objectForKey("_anaglyphController0") == null) {
            _connect(_owner(), _anaglyphController0, "controller");
        }

        if (_replacedObjects.objectForKey("_eoFrame0") == null) {
            _connect(_owner(), _eoFrame0, "window");
        }

        if (_replacedObjects.objectForKey("_anaglyphController0") == null) {
            _connect(_anaglyphController0, _owner(), "document");
        }
    }

    protected void _init() {
        super._init();
        if (!(_nsBox3.getLayout() instanceof EOViewLayout)) { _nsBox3.setLayout(new EOViewLayout()); }
        _nsImageView1.setSize(171, 158);
        _nsImageView1.setLocation(11, 11);
        ((EOViewLayout)_nsBox3.getLayout()).setAutosizingMask(_nsImageView1, EOViewLayout.WidthSizable | EOViewLayout.HeightSizable);
        _nsBox3.add(_nsImageView1);
        _nsButton0.setSize(71, 26);
        _nsButton0.setLocation(13, 173);
        ((EOViewLayout)_nsBox3.getLayout()).setAutosizingMask(_nsButton0, EOViewLayout.MaxXMargin | EOViewLayout.MinYMargin);
        _nsBox3.add(_nsButton0);
        _nsButton2.setSize(71, 26);
        _nsButton2.setLocation(112, 173);
        ((EOViewLayout)_nsBox3.getLayout()).setAutosizingMask(_nsButton2, EOViewLayout.MinXMargin | EOViewLayout.MinYMargin);
        _nsBox3.add(_nsButton2);
        if (!(_nsBox2.getLayout() instanceof EOViewLayout)) { _nsBox2.setLayout(new EOViewLayout()); }
        _nsBox3.setSize(193, 205);
        _nsBox3.setLocation(2, 15);
        ((EOViewLayout)_nsBox2.getLayout()).setAutosizingMask(_nsBox3, EOViewLayout.MinYMargin);
        _nsBox2.add(_nsBox3);
        _nsBox2.setBorder(new com.webobjects.eointerface.swing._EODefaultBorder("Left Image", true, "Lucida Grande", 11, Font.PLAIN));
        if (!(_nsBox1.getLayout() instanceof EOViewLayout)) { _nsBox1.setLayout(new EOViewLayout()); }
        _nsImageView2.setSize(171, 158);
        _nsImageView2.setLocation(11, 11);
        ((EOViewLayout)_nsBox1.getLayout()).setAutosizingMask(_nsImageView2, EOViewLayout.WidthSizable | EOViewLayout.HeightSizable);
        _nsBox1.add(_nsImageView2);
        _nsButton1.setSize(71, 26);
        _nsButton1.setLocation(13, 173);
        ((EOViewLayout)_nsBox1.getLayout()).setAutosizingMask(_nsButton1, EOViewLayout.MaxXMargin | EOViewLayout.MinYMargin);
        _nsBox1.add(_nsButton1);
        _nsButton3.setSize(71, 26);
        _nsButton3.setLocation(112, 173);
        ((EOViewLayout)_nsBox1.getLayout()).setAutosizingMask(_nsButton3, EOViewLayout.MinXMargin | EOViewLayout.MinYMargin);
        _nsBox1.add(_nsButton3);
        if (!(_nsBox0.getLayout() instanceof EOViewLayout)) { _nsBox0.setLayout(new EOViewLayout()); }
        _nsBox1.setSize(193, 205);
        _nsBox1.setLocation(2, 15);
        ((EOViewLayout)_nsBox0.getLayout()).setAutosizingMask(_nsBox1, EOViewLayout.MinYMargin);
        _nsBox0.add(_nsBox1);
        _nsBox0.setBorder(new com.webobjects.eointerface.swing._EODefaultBorder("Right Image", true, "Lucida Grande", 11, Font.PLAIN));
        _nsButton4.addActionListener((com.webobjects.eointerface.swing.EOControlActionAdapter)_registered(new com.webobjects.eointerface.swing.EOControlActionAdapter(_anaglyphController0, "exportFinalImage", _nsButton4), ""));

        if (_replacedObjects.objectForKey("_nsButton4") == null) {
            _setFontForComponent(_nsButton4, "Lucida Grande", 13, Font.PLAIN);
            _nsButton4.setMargin(new Insets(0, 2, 0, 2));
        }

        if (_replacedObjects.objectForKey("_anaglyphController0") == null) {
            _connect(_anaglyphController0, _nsButton4, "exportButton");
        }

        _nsButton3.addActionListener((com.webobjects.eointerface.swing.EOControlActionAdapter)_registered(new com.webobjects.eointerface.swing.EOControlActionAdapter(_anaglyphController0, "clearImage", _nsButton3), ""));

        if (_replacedObjects.objectForKey("_nsButton3") == null) {
            _setFontForComponent(_nsButton3, "Lucida Grande", 13, Font.PLAIN);
            _nsButton3.setMargin(new Insets(0, 2, 0, 2));
        }

        if (_replacedObjects.objectForKey("_anaglyphController0") == null) {
            _connect(_anaglyphController0, _nsButton3, "clearRightImageButton");
        }

        _nsButton2.addActionListener((com.webobjects.eointerface.swing.EOControlActionAdapter)_registered(new com.webobjects.eointerface.swing.EOControlActionAdapter(_anaglyphController0, "clearImage", _nsButton2), ""));

        if (_replacedObjects.objectForKey("_nsButton2") == null) {
            _setFontForComponent(_nsButton2, "Lucida Grande", 13, Font.PLAIN);
            _nsButton2.setMargin(new Insets(0, 2, 0, 2));
        }

        if (_replacedObjects.objectForKey("_anaglyphController0") == null) {
            _connect(_anaglyphController0, _nsButton2, "clearLeftImageButton");
        }

        _nsButton1.addActionListener((com.webobjects.eointerface.swing.EOControlActionAdapter)_registered(new com.webobjects.eointerface.swing.EOControlActionAdapter(_anaglyphController0, "loadImage", _nsButton1), ""));

        if (_replacedObjects.objectForKey("_nsButton1") == null) {
            _setFontForComponent(_nsButton1, "Lucida Grande", 13, Font.PLAIN);
            _nsButton1.setMargin(new Insets(0, 2, 0, 2));
        }

        if (_replacedObjects.objectForKey("_anaglyphController0") == null) {
            _connect(_anaglyphController0, _nsButton1, "loadRightImageButton");
        }

        _nsButton0.addActionListener((com.webobjects.eointerface.swing.EOControlActionAdapter)_registered(new com.webobjects.eointerface.swing.EOControlActionAdapter(_anaglyphController0, "loadImage", _nsButton0), ""));

        if (_replacedObjects.objectForKey("_nsButton0") == null) {
            _setFontForComponent(_nsButton0, "Lucida Grande", 13, Font.PLAIN);
            _nsButton0.setMargin(new Insets(0, 2, 0, 2));
        }

        if (_replacedObjects.objectForKey("_anaglyphController0") == null) {
            _connect(_anaglyphController0, _nsButton0, "loadLeftImageButton");
        }

        if (_replacedObjects.objectForKey("_anaglyphController0") == null) {
            _connect(_anaglyphController0, _eoFrame0, "window");
        }

        _jRadioButton0.addActionListener((com.webobjects.eointerface.swing.EOControlActionAdapter)_registered(new com.webobjects.eointerface.swing.EOControlActionAdapter(_anaglyphController0, "updateFinalImage", _jRadioButton0), ""));
        _jRadioButton1.addActionListener((com.webobjects.eointerface.swing.EOControlActionAdapter)_registered(new com.webobjects.eointerface.swing.EOControlActionAdapter(_anaglyphController0, "updateFinalImage", _jRadioButton1), ""));
        _setFontForComponent(_jRadioButton1, "Lucida Grande", 13, Font.PLAIN);
        _setFontForComponent(_jRadioButton0, "Lucida Grande", 13, Font.PLAIN);

        if (_replacedObjects.objectForKey("_nsMatrix0") == null) {
            _jRadioButton0.setSize(83, 18);
            _jRadioButton0.setLocation(0, 0);
            _nsMatrix0.add(_jRadioButton0);
            _jRadioButton1.setSize(83, 18);
            _jRadioButton1.setLocation(0, 20);
            _nsMatrix0.add(_jRadioButton1);
            _setFontForComponent(_nsMatrix0, "Lucida Grande", 13, Font.PLAIN);
        }

        if (_replacedObjects.objectForKey("_anaglyphController0") == null) {
            _connect(_anaglyphController0, _nsMatrix0, "colorModeRadioButtons");
        }

        if (_replacedObjects.objectForKey("_anaglyphController0") == null) {
            _connect(_anaglyphController0, _nsProgressIndicator0, "processingSpinner");
        }

        _nsImageView2.addActionListener((com.webobjects.eointerface.swing.EOControlActionAdapter)_registered(new com.webobjects.eointerface.swing.EOControlActionAdapter(_anaglyphController0, "updateFinalImage", _nsImageView2), ""));

        if (_replacedObjects.objectForKey("_anaglyphController0") == null) {
            _connect(_anaglyphController0, _nsImageView2, "rightImage");
        }

        _nsImageView1.addActionListener((com.webobjects.eointerface.swing.EOControlActionAdapter)_registered(new com.webobjects.eointerface.swing.EOControlActionAdapter(_anaglyphController0, "updateFinalImage", _nsImageView1), ""));

        if (_replacedObjects.objectForKey("_anaglyphController0") == null) {
            _connect(_anaglyphController0, _nsImageView1, "leftImage");
        }

        if (_replacedObjects.objectForKey("_anaglyphController0") == null) {
            _connect(_anaglyphController0, _nsImageView0, "finalImage");
        }

        if (!(_nsView0.getLayout() instanceof EOViewLayout)) { _nsView0.setLayout(new EOViewLayout()); }
        _nsImageView0.setSize(235, 210);
        _nsImageView0.setLocation(493, 11);
        ((EOViewLayout)_nsView0.getLayout()).setAutosizingMask(_nsImageView0, EOViewLayout.WidthSizable | EOViewLayout.HeightSizable);
        _nsView0.add(_nsImageView0);
        _nsBox0.setSize(197, 222);
        _nsBox0.setLocation(209, 0);
        ((EOViewLayout)_nsView0.getLayout()).setAutosizingMask(_nsBox0, EOViewLayout.MinXMargin | EOViewLayout.WidthSizable | EOViewLayout.HeightSizable);
        _nsView0.add(_nsBox0);
        _nsBox2.setSize(197, 222);
        _nsBox2.setLocation(10, 0);
        ((EOViewLayout)_nsView0.getLayout()).setAutosizingMask(_nsBox2, EOViewLayout.WidthSizable | EOViewLayout.MaxXMargin | EOViewLayout.HeightSizable);
        _nsView0.add(_nsBox2);
        _nsMatrix0.setSize(83, 38);
        _nsMatrix0.setLocation(409, 24);
        ((EOViewLayout)_nsView0.getLayout()).setAutosizingMask(_nsMatrix0, EOViewLayout.MinXMargin | EOViewLayout.MinYMargin);
        _nsView0.add(_nsMatrix0);
        _nsProgressIndicator0.setSize(32, 32);
        _nsProgressIndicator0.setLocation(431, 186);
        ((EOViewLayout)_nsView0.getLayout()).setAutosizingMask(_nsProgressIndicator0, EOViewLayout.MinYMargin);
        _nsView0.add(_nsProgressIndicator0);
        _nsButton4.setSize(82, 26);
        _nsButton4.setLocation(410, 78);
        ((EOViewLayout)_nsView0.getLayout()).setAutosizingMask(_nsButton4, EOViewLayout.MinYMargin);
        _nsView0.add(_nsButton4);

        if (_replacedObjects.objectForKey("_eoFrame0") == null) {
            _nsView0.setSize(738, 232);
            _eoFrame0.setTitle("Anaglyph Maker");
            _eoFrame0.setLocation(82, 584);
            _eoFrame0.setSize(738, 232);
        }
    }
}