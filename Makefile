help:
	@echo targets: fixperms, schedule

info:
	echo $(XFONT)

fixperms:
	chmod -Rc +x ~/bin ~/.xinitrc
	chmod -Rc go-wrx ~/.netrc ~/.pwsafe.dat ~/pim ~/.msmtprc

schedule:
	@rem -q

pwsafe-merge:
	scp lofn:.pwsafe.dat pwsafe
	pwsafe --merge pwsafe
	rm pwsafe
	scp .pwsafe.dat lofn:

.pwsafe.dat:
	scp lofn.sinedev.org:.pwsafe.dat .
	make fixperms

.Xdefaults: .Xdefaults.tt 
	xrdb -cpp ttpp -n $< > $@
	xrdb -load $@

.PHONY: schedule fixperms help
