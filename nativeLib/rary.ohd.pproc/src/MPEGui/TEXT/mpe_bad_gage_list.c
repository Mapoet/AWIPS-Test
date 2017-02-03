/*
** Generated by X-Designer
*/
/*
**LIBS: -lXm -lXt -lX11
*/

#include <stdlib.h>
#include <X11/Xatom.h>
#include <X11/Intrinsic.h>
#include <X11/Shell.h>

#include <Xm/Xm.h>
#include <Xm/DialogS.h>
#include <Xm/Form.h>
#include <Xm/List.h>
#include <Xm/PushB.h>
#include <Xm/ScrollBar.h>


#include "mpe_bad_gage_list.h"

Widget badGageSH = (Widget) NULL;
Widget badGageFM = (Widget) NULL;
Widget badGageLS = (Widget) NULL;
Widget okPB = (Widget) NULL;
Widget delPB = (Widget) NULL;



void create_badGageSH (Widget parent)
{
	Widget children[3];      /* Children to manage */
	Display *display = XtDisplay ( parent );
	Arg al[64];                    /* Arg List */
	register int ac = 0;           /* Arg Count */
	XrmValue from_value, to_value; /* For resource conversion */
	XPointer to_address; /* For Thread-safe resource conversion */ 
	Pixel to_pixel; /* For Thread-safe resource conversion */ 
	XtPointer tmp_value;             /* ditto */
	XmString xmstrings[16];    /* temporary storage for XmStrings */
	Widget scrolledList1 = (Widget)NULL;
	Widget scrollbar1 = (Widget)NULL;
	Widget scrollbar2 = (Widget)NULL;

	XtSetArg(al[ac], XmNallowShellResize, TRUE); ac++;
	badGageSH = XmCreateDialogShell ( parent, (char *) "badGageSH", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNautoUnmanage, FALSE); ac++;
	badGageFM = XmCreateForm ( badGageSH, (char *) "badGageFM", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNvisibleItemCount, 9); ac++;
	if (DefaultDepthOfScreen(DefaultScreenOfDisplay(display)) != 1) {

		from_value.addr = "#00007e18ffff" ;
		from_value.size = strlen( from_value.addr ) + 1;
		to_value.size = sizeof(Pixel);
		to_value.addr = (XPointer) &to_pixel;
		XtConvertAndStore (badGageFM, XmRString, &from_value, XmRPixel, &to_value);

		if ( to_value.addr ) {
			XtSetArg(al[ac], XmNselectColor, (*((Pixel*) to_value.addr))); ac++;
		}
	}
	XtSetArg(al[ac], XmNselectionPolicy, XmSINGLE_SELECT); ac++;
	XtSetArg(al[ac], XmNscrollBarDisplayPolicy, XmSTATIC); ac++;
	badGageLS = XmCreateScrolledList ( badGageFM, (char *) "badGageLS", al, ac );
	ac = 0;
	scrolledList1 = XtParent ( badGageLS );

	XtSetArg(al[ac], XmNhorizontalScrollBar, &scrollbar1); ac++;
	XtSetArg(al[ac], XmNverticalScrollBar, &scrollbar2); ac++;
	XtGetValues(scrolledList1, al, ac );
	ac = 0;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "OK", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	okPB = XmCreatePushButton ( badGageFM, (char *) "okPB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Delete Selected Item", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	delPB = XmCreatePushButton ( badGageFM, (char *) "delPB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );


	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -171); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -159); ac++;
	XtSetValues ( scrolledList1, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_WIDGET); ac++;
	XtSetArg(al[ac], XmNtopWidget, scrolledList1); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetValues ( okPB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 171); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -193); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 28); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -160); ac++;
	XtSetValues ( delPB, al, ac );
	ac = 0;
	if (badGageLS != (Widget) 0) { XtManageChild(badGageLS); }
	if ((children[ac] = okPB) != (Widget) 0) { ac++; }
	if ((children[ac] = delPB) != (Widget) 0) { ac++; }
	if (ac > 0) { XtManageChildren(children, ac); }
	ac = 0;

/*  ==============  Statements containing RCS keywords:  */
{static char rcs_id1[] = "$Source$";
 static char rcs_id2[] = "$Id$";}
/*  ===================================================  */

}
