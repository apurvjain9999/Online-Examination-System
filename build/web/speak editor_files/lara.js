var MediaTypes = {ARTICLE: "news", PHOTO: "photos", TALK: "talk", PASSPORT: "users", PROPERTY: "realestate", WEBLOG: "posts", VIDEO: "videos"};

//Windows & Admin

//Signed out
var MEDIA_EMAIL =  { id:"MEDIA_EMAIL", title:"Email Item", path:"/_ui/email", width:"380", height:"400"};
var MEDIA_ENQUIRE = { id:"MEDIA_ENQUIRE", title:"Email Inquiry", path:"/_ui/enquire", width:"380", height:"400"};
var SIGN_UP = { id:"SIGN_UP", title:"Sign Up", path:"/_ui/signup", width:"380", height:"400"};
var SIGN_IN = { id:"SIGN_IN", title:"Sign In", path:"/_ui/signin", width:"380", height:"200"};
var PASSWORD_RECOVERY = { id:"PASSWORD_RECOVERY", title:"Password Recovery", path:"/_ui/passwordrecovery", width:"380", height:"200"};
var SHOW_MAP = { id: "SHOW_MAP", title: "Map", path: "/_ui/map", width: "700", height: "500" };
var SHOW_POPUP = { id: "SHOW_POPUP", title: "", path: "/_ui/popwin", width: "700", height: "500" };
var ADD_POST = { id: "ADD_POST", title: "Start a new discussion", path: "/_ui/addpost", width: "700", height: "500" };
var SHOW_CONTENT = { id: "SHOW_CONTENT", title: "", path: "/_ui/contentwin", width: "700", height: "500" };
var SITE_WIN = { id: "SITE_WIN", title: "", path: "/_ui/sitewin", width: "900", height: "1000" };

//Signed In
var MEDIA_LIBRARY = { id:"MEDIA_LIBRARY", title:"Your File Library", path:"/_ui/browser", width:"730", height:"500"};
var CHANGE_PASSWORD = { id:"CHANGE_PASSWORD", title:"Change Password", path:"/_ui/changepassword", width:"400", height:"200"};
var FEATURE_OPTIONS = { id: "FEATURE_OPTIONS", title: "Feature Options", path: "/_ui/editfeature", width: "730", height: "500" };
var CDESIGN = { id: "CDESIGN", title: "Site Design", path: "/_ui/cdesign", width: "800", height: "500" };
var SITE_SETTINGS = { id: "SITE_SETTINGS", title: "Site Settings", path: "/_ui/settings" };
var ACCOUNT_DETAILS = { id: "ACCOUNT_DETAILS", title: "Account Details", path: "/_ui/account" };
var MARKETING = { id: "MARKETING", title: "Marketing", path: "/_ui/marketing" };
var SITE_PAGES = { id:"SITE_PAGES", title:"Site Pages", path:"/_ui/pages"};
var PUBLISH = { id: "PUBLISH", title: "Publish Content", path: "/_ui/publish" };
var ADDEDIT_MEDIA = { id: "ADDEDIT_MEDIA", title: "Add Edit Media", path: "/_ui/addeditmedia" };




function geoMedia() { };

geoMedia.prototype = {
    serverPath: "/_ui/media",
    deleteItem: function(mediaType, id, page, pagesize, silent) {
        if (!silent)
            if (confirm("Are you sure you want to delete this item?") == false)
            return false;

        var data = new dataObject();
        data.add("MediaType", mediaType);
        data.add("MediaId", id);

        if (page)
            data.add("Page", page);
        if (pagesize)
            data.add("PageSize", pagesize);

        lara.indicateOn();
        lara.request(this.serverPath + ":Delete", data, function(result) { mediaItem.processListChange(result); });
    },
    publish: function(mediaType, id, page, pagesize) {
        if (confirm("Are you sure you want to publish this item?") == false)
            return false;

        var data = new dataObject();
        data.add("MediaType", mediaType);
        data.add("MediaId", id);
        data.add("Page", page);
        data.add("PageSize", pagesize);

        lara.indicateOn();
        lara.request(this.serverPath + ":PublishItem", data, function(result) { mediaItem.processListChange(result); });
    },
    processListChange: function(result) {
        if (result.success) {
            if (result.featureId)
                $(result.featureId).innerHTML = result.html;
            else
                window.location = BASE_URL;
        }
        else {
            alert(result.error);
        }
        lara.indicateOff();
    },
    promoteItem: function(link, mediaType, mediaId) {
        if (lara.ready) {
            if (!link.disabled) {
                link.disabled = true;

                var data = new dataObject();
                data.add("mediatype", mediaType);
                data.add("mediaid", mediaId);

                this.promoteLink = link;
                this.promoterCount = link.parentNode.firstChild;

                lara.request(this.serverPath + ":Promote", data, function(result) { mediaItem.processPromote(result); });
            }
        }
    },
    processPromote: function(result) {
        if (result.success) {
            this.promoteLink.innerHTML = "Great!";
            this.promoteLink.style.color = "Green";
            var i = parseInt(this.promoterCount.innerHTML);
            i = i + 1;
            this.promoterCount.innerHTML = i + "<br /><span>promoters</span>";
            this.promoterCount.style.color = "Green";
        }
        else {
            //show error message
            alert(result.error);
        }
        this.promoteLink.disabled = false;
    },
    postComment: function(Path, FeatureId) {

        $("ResultText").innerHTML = "";
        if ($("CommentText").value == "") {
            $("ResultText").innerHTML = "You must enter a comment.";
            return false;
        }

        var data = new dataObject();
        data.add("comment", $("CommentText").value);
        data.add("discussionid", $("DiscussionId").value);
        data.add("mediatype", $("MediaType").value);
        data.add("mediaid", $("MediaId").value);
        data.add("Path", Path);
        data.add("FeatureId", FeatureId);

        if ($("CommentSelectorPath")) {
            data.add("Location", $("CommentSelectorPath").value);
        }
        if ($("CommentWebsite")) {
            data.add("Website", $("CommentWebsite").value);
        }
        if ($("CommentNotify")) {
            data.add("Notify", $("CommentNotify").checked);
        }
        if ($("CommentName")) {
            data.add("username", $("CommentName").value);

            if ($("CommentSignUp")) {

                if ($("CommentSignUp").style.display == "block") {
                    if ($("CommentNewPassword").value != $("CommentConfirmPassword").value) {
                        $("ResultText").innerHTML = "Passwords do not match.";
                        return false;
                    }
                    if ($("CommentEmail").value == "" || $("CommentNewPassword") == "" || $("CommentNewUser").value == "") {
                        $("ResultText").innerHTML = "Email, password and username are required.";
                        return false;
                    }

                    data.add("UserName", $("CommentNewUser").value);
                    data.add("Password", $("CommentNewPassword").value);
                    data.add("Remember", $("RememberMe").checked);
                    data.add("Email", $("CommentEmail").value);
                    data.add("ContactList", $("CommentContactList").checked);

                }
            }
            if ($("CommentSignIn")) {
                if ($("CommentSignIn").style.display == "block") {
                    data.add("ExistingUser", $("CommentExistingUser").value);
                    data.add("ExistingPassword", $("CommentExistingPassword").value);
                }
            }

        }
        $("PostCommentButton").disabled = true;
        $("CommentIndicator").style.display = "inline";

        lara.request(this.serverPath + ":PostComment", data, function(result) { mediaItem.processPostComment(result); });
    },
    processPostComment: function(result) {
        if (result.success) {
            if (result.signIn)
                window.location = window.location;

            $(result.featureId).innerHTML = result.html;

            if (result.RequiresApproval) {
                $("ResultText").innerHTML = "<h3>Thank you for your comment!<br />We will review what you've written and it should appear here soon.</h3>";
            }
        }
        else {
            $("ResultText").innerHTML = result.error;
        }
        $("PostCommentButton").disabled = false;
        $("CommentIndicator").style.display = "none";

    },
    toggleCommentSignUp: function() {

        if ($("CommentSignUp").style.display == "block" || $("CommentSignIn").style.display == "block") {
            $("CommentSignIn").style.display = "none";
            $("CommentSignUp").style.display = "none";
        }
        else {
            $("CommentSignIn").style.display = "none";
            $("CommentSignUp").style.display = "block";
        }
    },
    toggleCommentSignIn: function() {
        if ($("CommentSignIn").style.display == "none") {
            $("CommentSignUp").style.display = "none";
            $("CommentSignIn").style.display = "block";
        }
        else {
            $("CommentSignUp").style.display = "block";
            $("CommentSignIn").style.display = "none";
        }
    },
    //Newsletter
    sendNewsLetter: function() {
        if (confirm("Are you sure you want to send the news letter?  (This page will be emailed to all users on your contact list)")) {
            lara.indicateOn();
            $("SendNewsletter").disabled = true;
            lara.request(this.serverPath + ":SendNewsletter", null, function(result) { mediaItem.processSendNews(result); });
        }

    },
    processSendNews: function(result) {
        if (result.success) {
            alert(result.sendResult);
        }
        else {
            alert(result.error);
        }
        lara.indicateOff();
        $("SendNewsletter").disabled = false;
    },
    registerDownload: function(counter) {
        lara.request(this.serverPath + ":RegisterLinkClick", "Counter=" + counter, function() { });
    },
    updateCounter: function() {
        var data = new dataObject();
        data.add("Counter", $("DownloadCounterName").value);
        data.add("Count", $("EditDownloadCount").value);
        lara.request(this.serverPath + ":UpdateLinkCounter", data, function() { });
        $("UpdateCounterButton").style.display = "none";
    },
    submitMedia: function() {

        //Validate
        if (!this.validateSubmit())
            return;

        $("SubmitMediaButton").disabled = true;

        var data = new dataObject();
        data.add("Source", $("SubmitUrl").value);
        data.add("Title", $("SubmitTitle").value);
        data.add("Path", $("SubmitMediaSelectorPath").value);
        data.add("Description", $("SubmitDescription").value);
        data.add("Channels", this.getSelectedChannels("MediaChannels"));
        data.add("Tags", $("SubmitTags").value);

        lara.indicateOn();
        lara.request(this.serverPath + ":SubmitMedia", data, function(result) { mediaItem.processSubmit(result); });

    },
    processSubmit: function(result) {
        if (result.success) {
            window.location = result.location;
        }
        else {
            alert(result.error);
        }
        $("SubmitMediaButton").disabled = false;
        lara.indicateOff();
    },
    validateSubmit: function() {

        var passed = true;
        if ($("SubmitUrl").value == "") {
            $("UrlRequired").style.display = "block";
            passed = false;
        }

        if ($("SubmitTitle").value == "") {
            $("TitleRequired").style.display = "block";
            passed = false;
        }

        if ($("SubmitDescription").value == "") {
            $("DescriptionRequired").style.display = "block";
            passed = false;
        }

        if (this.getSelectedChannels("MediaChannels") == "") {
            $("ChannelRequired").style.display = "block";
            passed = false;
        }

        return passed;
    },
    submitFeed: function() {

        //Validate
        //        if (!this.validateSubmit())
        //            return;

        $("SubmitMediaButton").disabled = true;

        var data = new dataObject();
        data.add("Url", $("SubmitUrl").value);
        data.add("Path", $("SubmitFeedSelectorPath").value);
        data.add("TitleKeys", $("TitleKeywords").value);
        data.add("BodyKeys", $("DescriptionKeywords").value);
        data.add("Channels", this.getSelectedChannels("MediaChannels"));

        lara.indicateOn();
        lara.request(this.serverPath + ":SubmitFeed", data, function(result) { mediaItem.processSubmitFeed(result); });

    },
    processSubmitFeed: function(result) {
        if (result.success) {
            $("SubmitFeedPanel").style.display = "none";
            $("FeedAcceptedPanel").style.display = "block";
            $("FeedAcceptedPanel").innerHTML = "The following feed: <h3>" + result.title + "</h3><p>" + result.description + "</p><p>Was submitted and will be reviewed.</p>";
        }
        else {
            alert(result.error);
        }
        $("SubmitMediaButton").disabled = false;
        lara.indicateOff();
    },
    getSelectedChannels: function(ChannelBox) {
        ChannelBoxes = $(ChannelBox).getElementsByTagName("input");

        Channels = "";

        for (i = 0; i < ChannelBoxes.length; i++) {
            var ChannelBox = ChannelBoxes[i];
            if (ChannelBox.checked) {
                Channels += ChannelBox.value + ",";
            }
        }
        return Channels;
    }
};
var mediaItem = new geoMedia();

function geoPayment() { };

geoPayment.prototype = {
    serverPath: "/_ui/payment",
    changeQuantity: function(index) {
        $("FieldValue" + index).value = $("FieldQuantity" + index).value * $("FieldPrice" + index).value;
        this.changeAmount();
    },
    changeAmount: function() {
        var sum = 0;
        var fields = $getByClass("PayFieldAmount");
        for (var i = 0; i < fields.length; i++) {
            var val = parseFloat(fields[i].value);
            if (val > 0)
                sum += val;
        }
        $("PayAmount").value = sum;
    },
    validateInfo: function() {

        var valid = true;

        $("PayAmountValid").innerHTML = "";
        $("PayDescriptionValid").innerHTML = "";
        $("PayEmailValid").innerHTML = "";
        $("PayCardNumberValid").innerHTML = "";
        $("PayCardNameValid").innerHTML = "";
        $("PayCardCVVValid").innerHTML = "";

        //Remove leading $ sign
        if ($("PayAmount").value.indexOf("$") == 0)
            $("PayAmount").value = $("PayAmount").value.substring(1, $("PayAmount").value.length);

        if ($("PayDescription").value.length == 0) {
            $("PayDescriptionValid").innerHTML = "Please enter a payment description.";
            valid = false;
        }
        else {
            //Insert "Invoice #"
            if (!isNaN($("PayDescription").value))
                $("PayDescription").value = "Invoice #" + $("PayDescription").value;
        }
        if ($("PayEmail").value.length == 0) {
            $("PayEmailValid").innerHTML = "Please enter your email address.";
            valid = false;
        }

        if ($("PayFirstName")) {

            $("PayFirstNameValid").innerHTML = "";
            $("PayLastNameValid").innerHTML = "";
            $("PayAddress1Valid").innerHTML = "";
            $("PayCityValid").innerHTML = "";
            $("PayStateValid").innerHTML = "";
            $("PayPostalCodeValid").innerHTML = "";

            if ($("PayFirstName").value.length == 0) {
                $("PayFirstNameValid").innerHTML = "Please enter your first name.";
                valid = false;
            }
            if ($("PayLastName").value.length == 0) {
                $("PayLastNameValid").innerHTML = "Please enter your last name.";
                valid = false;
            }
            if ($("PayAddress1").value.length == 0) {
                $("PayAddress1Valid").innerHTML = "Please enter your address.";
                valid = false;
            }
            if ($("PayCity").value.length == 0) {
                $("PayCityValid").innerHTML = "Please enter your city.";
                valid = false;
            }
            if ($("PayState").value.length == 0) {
                $("PayStateValid").innerHTML = "Please enter your state or province.";
                valid = false;
            }
            if ($("PayPostalCode").value.length == 0) {
                $("PayPostalCodeValid").innerHTML = "Please enter your zip or postal code.";
                valid = false;
            }
        }

        if ($("PayCardNumber").value.length == 0) {
            $("PayCardNumberValid").innerHTML = "Please enter a valid credit card number.";
            valid = false;
        }
        if ($("PayCardName").value.length == 0) {
            $("PayCardNameValid").innerHTML = "Please enter the name which appears on your credit card.";
            valid = false;
        }
        if ($("PayCardCVV").value.length == 0) {
            $("PayCardCVVValid").innerHTML = "Please enter the 3 or 4 digit security code from the back of your card.";
            valid = false;
        }

        //ensure pay amount is a number.  
        if (isNaN($("PayAmount").value) || $("PayAmount").value.length == 0) {
            $("PayAmountValid").innerHTML = "Please enter a valid number.";
            valid = false;
        }

        if (valid) {
            var statement = "<p>An amount of <b>$" + $("PayAmount").value + "</b> will be charged to your credit card.</p><p>Click the button below to confirm this payment.</p>";
            $("ConfirmPaymentAmount").innerHTML = statement;
            $("PaymentForm").style.display = "none";
            $("ConfirmPayment").style.display = "block";
        }
    },
    stepBack: function() {
        $("ConfirmPayment").style.display = "none";
        $("PaymentResultForm").style.display = "none";
        $("PaymentForm").style.display = "block";
    },
    makePayment: function(id, locator) {

        var data = new dataObject();
        data.add("PaymentDescription", $("PayDescription").value);
        data.add("PaymentAmount", $("PayAmount").value);
        data.add("PaymentEmail", $("PayEmail").value);
        if ($("PayFirstName")) {
            data.add("PaymentFirstName", $("PayFirstName").value);
            data.add("PaymentLastName", $("PayLastName").value);
            data.add("PaymentPhone", $("PayPhone").value);
            data.add("PaymentAddress1", $("PayAddress1").value);
            data.add("PaymentAddress2", $("PayAddress2").value);
            data.add("PaymentCity", $("PayCity").value);
            data.add("PaymentState", $("PayState").value);
            data.add("PaymentCountry", $("PayCountry").value);
            data.add("PaymentPostalCode", $("PayPostalCode").value);
        }
        data.add("PaymentCardNumber", $("PayCardNumber").value);
        data.add("PaymentCardName", $("PayCardName").value);
        data.add("PaymentCardType", $("PayCardType").value);
        data.add("PaymentCardCVV", $("PayCardCVV").value);
        data.add("PaymentCardMonth", $("PayCardMonth").value);
        data.add("PaymentCardYear", $("PayCardYear").value);
        data.add("FeatureId", id);
        data.add("FeatureLocator", locator);

        $("PaymentProcessing").style.display = "block";
        $("ConfirmPayment").style.display = "none";

        lara.indicateOn();
        lara.request(this.serverPath + ":MakePayment", data, function(result) { payment.processMakePayment(result); });
    },
    processMakePayment: function(result) {
        if (result.success) {
            $("PaymentProcessing").style.display = "none";
            $("PaymentResultForm").style.display = "block";

            $("PaymentResult").innerHTML = result.html;
        }
        else {
            alert(result.error);
        }
        lara.indicateOff();
    },
    resetForm: function() {
        $("PayAmount").value = "";
        $("PayDescription").value = "";

        $("PaymentResultForm").style.display = "none";
        $("PaymentForm").style.display = "block";
    },
    selectCredit: function(amount) {
        $("CreditAmount").value = amount;
        if (amount == 0) {
            $("EnterAmount").style.display = "block";
            $("CreditAmount").focus();
        } else {
            $("EnterAmount").style.display = "none";
        }
    },
    buyCredit: function(store) {
        if (parseInt($("CreditAmount").value) < 5) {
            alert("There is a minimum credit purchase of $5.");
            return;
        }
        var data = new dataObject();
        data.add("email", $("CreditEmail").value);
        data.add("amount", $("CreditAmount").value);
        data.add("store", store);
        lara.indicateOn();
        lara.request(this.serverPath + ":BuyCredit", data, function(result) { payment.processBuyCredit(result); });        
    },
    processBuyCredit: function(result) {
        if (result.success) {
            window.location = result.url;
        }
        else {
            alert(result.error);
            lara.indicateOff();
        }
    }
};
var payment = new geoPayment();






//GEO WINDOW
function geoWindow(config, parameters)
{
    this.id = config.id;
    this.title = config.title;
    this.path = config.path;
    this.width = config.width;
 
    lara.indicateOn();
 
    this.window = document.createElement("div");
    this.window.id = this.id;
    this.window.className = "WinLoading";
    this.window.style.width = this.width + "px";
    this.window.style.height = config.height + "px";
    this.window.style.position = "absolute";
    this.window.style.zIndex = 20;

    if ($("map3d")) {
        this.shim = document.createElement("iframe");
        this.shim.className = "WindowShim";
        this.shim.frameBorder = 0;
        this.shim.scrolling = "no";
        this.shim.style.zIndex = -1;
        this.shim.style.position = "absolute";
        this.shim.style.top = 0;
        this.shim.style.left = 0;
        this.shim.width = this.width + "px";
        this.shim.height = config.height + "px";
        this.window.appendChild(this.shim);
    }
    
    
    //center in the screen - screenTop and screenLeft are used to position the screen relative to scroll
    this.window.setAttribute("screenTop", ((document.documentElement.clientHeight-config.height)/2));
    this.window.setAttribute("screenLeft", ((document.documentElement.clientWidth - this.width) / 2));
    document.body.appendChild(this.window);

    this.move();

    var self = this;
    lara.request(this.path + parameters, null, function(result) { self.load(result); }, true);  
};
geoWindow.prototype = {
    load: function (result) {

        this.window.style.height = "";

        this.window.className = "Window";

        //add window corner
        var corner = document.createElement("div");
        corner.className = "WCorner";
        this.window.appendChild(corner);

        //add window header
        var header = document.createElement("div");
        header.className = "WHeader";
        dragdrop.makeDraggable(this.window, header);
        this.window.appendChild(header);

        //add close button
        var close = document.createElement("div");
        close.className = "WClose";
        var self = this;
        close.onclick = function () { self.close(); };
        header.appendChild(close);

        //add screen Title
        var title = document.createElement("div");
        title.innerHTML = this.title;
        title.className = "WTitle";
        header.appendChild(title);

        //add screen content
        var content = document.createElement("div");
        content.className = "WContent";
        if (result.error)
            content.innerHTML = result.error;
        else
            content.innerHTML = result;

        this.window.appendChild(content);

        //add status bar
        var footer = document.createElement("div");
        footer.className = "WFooter";
        this.window.appendChild(footer);

        if (this.shim) {
            content.style.height = this.shim.offsetHeight - header.offsetHeight - 2 + "px";
        }

        //Load javascript for the screen
        lara.include(BASE_URL + this.path.replace("/_ui/", "/_ui/jsw/") + ".js");

        lara.refreshScripts(this.window);

        lara.indicateOff();
    },
    move: function () {
        var top = parseInt(this.window.getAttribute("screenTop")) + lara.scrollTop();
        if (top < 10)
            top = 10;
        this.window.style.top = top + "px";
        this.window.style.left = (parseInt(this.window.getAttribute("screenLeft")) + lara.scrollLeft()) + "px";
    },
    close: function () {
        if (this.onclose) { this.onclose.call(); }
        lara.exclude(BASE_URL + this.path.replace("/_ui/", "/_ui/jsw/") + ".js");
        lara.windows[this.id] = null;
        document.body.removeChild(this.window);
    },
    hide: function () {
        this.window.style.display = "none";
    },
    show: function () {
        this.window.style.display = "block";
    },
    preview: function (link, showEdit, exitCallback) {
        admin.showEdit(false);
        this.window.style.display = "none";

        admin.hide();

        this.onExitPreview = exitCallback;
        if (link) {
            var exit = link.cloneNode(true);
            exit.id = "ExitPreviewLink";
            exit.innerHTML = "<span>Exit Preview</span>";
            exit.style.position = "absolute";
            var pos = ui.findPos(link);
            exit.style.left = pos.x + "px";
            exit.style.top = pos.y + "px";
            exit.disabled = false;
            var self = this;
            exit.onclick = function () { self.exitPreview(null, showEdit); document.body.removeChild(this); return false; };
            document.body.appendChild(exit);
            document.onmousemove = function (ev) { var linkPos = dragdrop.mousePos(ev); var exit = $("ExitPreviewLink"); exit.style.top = linkPos.y - 16 + "px"; exit.style.left = linkPos.x - 60 + "px"; };
        }

    },
    exitPreview: function (link, showEdit) {
        this.show();
        admin.show();
        document.onmousemove = null;
        admin.showEdit(showEdit);
        if (this.onExitPreview)
            this.onExitPreview.call();
    }
};

function geoDragDrop() {};

geoDragDrop.prototype = {
    //target: the element that will be dragged
    //trigger: the element used to start the drag
    //onDrop: the function to call when the object is dropped
    //onStartDrag: the function to call when the drag starts
    makeDraggable: function(target, trigger, ondrop, onstartdrag) {
	    if(!target) { return; }
	    
	    if (!trigger)
	        trigger = target;
	        
	    //begin the drag on the mouse down event of the trigger element
	    trigger.onmousedown = function(ev){
	        
	        if (onstartdrag)
	            onstartdrag.call();
    	        			    		    
	        if (ondrop)
	            dragdrop.ondrop = ondrop;

		    //Geo Specific: Clear unsupported mouse events
		    target.onmouseover = null;
		    target.onmouseout = null;
		    
		    //Prevent mouse selecting text.
		    ui.disableSelection();
		    
		    //Get the mouse offset
		    dragdrop.offset = dragdrop.getOffset(target, ev);

            //Offset width - border width
		    target.style.width = target.offsetWidth + "px";
            target.style.position = "absolute";
	            
            if (dragdrop.dropTargets.length>0) {
                //geo specific, make a placeholder for feature drags
                //move the target item onto the body
	            dragdrop.currentParent = target.parentNode;
	            if (target.parentNode.childNodes.length == 1) {
	                dragdrop.placeholder = document.createTextNode(" ");
	                target.parentNode.appendChild(dragdrop.placeholder); 
	            }
	            target.parentNode.removeChild(target);
	            document.body.appendChild(target);
	        }
	        
	        //Setup the move and drop events
		    document.onmousemove = function(ev) { dragdrop.mouseMove(ev); };
            document.onmouseup = function(ev) { dragdrop.mouseUp(ev); }; 		

            //save the drag object
		    dragdrop.dragObject = target;
            dragdrop.create = false;
		    return false;
	    };
    },
    makeCreatable: function(target, trigger, ondrop, onstartdrag) {
	    if(!target) { return; }
	    
	    if (!trigger)
	        trigger = target;
	        
	    //begin the drag on the mouse down event of the trigger element
	    trigger.onmousedown = function(ev){
	        
	        if (onstartdrag)
	            onstartdrag.call();
    	        			    		    
	        if (ondrop)
	            dragdrop.ondrop = ondrop;

		    //Geo Specific: Clear unsupported mouse events
		    target.onmouseover = null;
		    target.onmouseout = null;
		    
		    //Prevent mouse selecting text.
		    ui.disableSelection();
		    
		    //Get the mouse offset
		    dragdrop.offset = dragdrop.getOffset(target, ev);

            var pos = dragdrop.mousePos(ev);
            createObject = target.cloneNode(true);
            createObject.style.width = target.offsetWidth + "px";
            createObject.style.position = "absolute";	    
	        createObject.style.top = (pos.y - dragdrop.offset.y) + "px";
	        createObject.style.left = (pos.x - dragdrop.offset.x) + "px";    
            document.body.appendChild(createObject);
	        
	        //Setup the move and drop events
		    document.onmousemove = function(ev) { dragdrop.mouseMove(ev); };
            document.onmouseup = function(ev) { dragdrop.mouseUp(ev); }; 		

            //save the drag object
		    dragdrop.dragObject = createObject;
            dragdrop.create = true;
            
		    return false;
	    };    
    },
    mouseMove: function(ev){
	    ev = ev || window.event;
	    
	    var pos = this.mousePos(ev);

	    if (this.dragObject)
	    {
		    this.dragObject.style.top = (pos.y - this.offset.y) + "px";
		    this.dragObject.style.left = (pos.x - this.offset.x) + "px";
    		
		    //If over drop target hover effect the target
            this.evaluate(pos, false);
		    return false;
	    }		
    },
    mousePos: function(ev) {
        ev = ev || window.event;
	    if(ev.pageX || ev.pageY)
		    return { x:ev.pageX, y:ev.pageY };

	    return { x:ev.clientX + document.documentElement.scrollLeft, y:ev.clientY + lara.scrollTop() };
    },
    mouseUp: function(ev){
	    ev = ev || window.event;
	    
	    var pos = this.mousePos(ev);
    	
	    //Remove the created drag object
	    if (this.dragObject) {
	    
	        //geo specific
            if(lara.windows[this.dragObject.id] != null) {
                //I just dragged a window set screen position
                this.dragObject.setAttribute("screenTop", (pos.y - this.offset.y - lara.scrollTop()));
                this.dragObject.setAttribute("screenLeft", (pos.x - this.offset.x - lara.scrollLeft()));
            }
            
            //If over drop target we just dropped on a target.
            var isHit = this.evaluate(pos, true); 
       
            if (this.create)
                document.body.removeChild(createObject);
            else {
                if (this.ondrop && !isHit) {
                
                    //Return the object to its former place.
                    this.dragObject.style.position = "";
                    this.dragObject.style.left = "0px";
                    this.dragObject.style.top = "0px";    
                    this.currentParent.appendChild(this.dragObject);    
                    this.currentParent.removeChild(this.placeholder);  
                    
                }
            }            
        }

        this.ondrop = null;
	    this.dragObject = null;
	    this.create = false;
	    this.currentParent = null;
	    this.placeholder = null;
	    document.onmousemove = null;
        document.onmouseup = null;   	
        ui.enableSelection();
    },                  
    //Check if we are over a drop target
    evaluate: function(pos, isDrop) {
        
        var isHit = false;
        for(var i=0;i<this.dropTargets.length;i++)
        {
            var target = this.dropTargets[i];
            var dropPos = ui.findPos(target);
            var width = target.offsetWidth;
            var height = target.offsetHeight;
            
            target.style.backgroundColor="";           
            if (pos.x < (dropPos.x + width) && pos.x > dropPos.x)
            {
                if (pos.y < (dropPos.y + height) && pos.y > dropPos.y)
                {
                    isHit = true;
                    if (isDrop) {
                        //release the width
                        this.dragObject.style.width = "";
                        if (this.ondrop)
                            this.ondrop.call(null, this.dragObject, target);

                        break;
                    }
                    else {
                        //We are hovering over this target highlight the item
                        target.style.backgroundColor="#ccc";
                    }
                }
            }
        }
        return isHit;
    },    
    clearDropTargets: function() {
        this.dropTargets = [];
    },
    dropTargets: [],    
    makeDroppable: function(target) {
	    if(!target) { return; }
        this.dropTargets.push(target);
    },
    getOffset: function(target, ev) {
	    ev = ev || window.event;
	    var elPos = ui.findPos(target);
	    var pos = this.mousePos(ev);

    	return { x:pos.x - elPos.x, y:pos.y - elPos.y };
    }    
};

var dragdrop = new geoDragDrop();








//TREE
function geoTree() {};

geoTree.prototype = {
    serverPath: "/_ui/tree",
    g: function(node) {
        this.clickedNode = node;
        
        var childDiv = node.parentNode.parentNode.getElementsByTagName("div")[0];
        if (childDiv) {
            if (childDiv.style.display=="none") {
                childDiv.style.display = "block";
                this.clickedNode.parentNode.firstChild.className = "e";
            }
            else {
                childDiv.style.display ="none";
                this.clickedNode.parentNode.firstChild.className = "c";
            }
        } 
        else {
            this.newTree = document.createElement("div");
            this.newTree.className = "v";
            this.newTree.innerHTML = "<input type='button' class='em'/>loading...";
            
            this.clickedNode.parentNode.parentNode.appendChild(this.newTree);
            this.clickedNode.parentNode.firstChild.className = "e";

            var data = new dataObject();
            data.add("path", node.parentNode.parentNode.id);
            data.add("mediatype", $("TreeMediaType").value);

            lara.request(this.serverPath + ":GetSubTree", data, function(result) { t.showSubtree(result); });                    
        }
    },
    showSubtree: function(result) {
        if (result.success)
            this.newTree.innerHTML = result.subtree;
        else
            this.newTree.innerHTML = result.error;
    }
};

var t = new geoTree();//SPOT SELECTOR
function geoSelector() { };

geoSelector.prototype = {
    serverPath: "/_ui/selector",
    spotSelected: function(selected) {

        this.current = selected;
        this.id = this.getSelectorId(selected);
        var selectedPath = $(this.id + "Path");
        var selectedId = $(this.id + "Id");
        
        var childDiv = selected.parentNode.getElementsByTagName("div")[0];
        if (childDiv) {
            selected.parentNode.removeChild(childDiv);
        }

        if (selected.options[selected.selectedIndex].value == "select") {
            selectedId.value = selected.id.split('|')[0];
            selectedPath.value = selected.id.split('|')[1];
        }
        else {
            //Get the next dropdown from the server
            lara.indicateOn();
            selectedId.value = selected.options[selected.selectedIndex].value.split('|')[0];
            selectedPath.value = selected.options[selected.selectedIndex].value.split('|')[1];
            this.disableSelectors(true);

            var data = new dataObject();
            data.add("path", selectedPath.value);
            data.add("id", selectedId.value);                
            lara.request(this.serverPath + ":GetDropDown", data, function(result) { selector.showDropDown(result); });
        }
    },
    getSelectorId: function(selector) {
        var parent = selector.parentNode;
        while (parent.className != "SpotSelector" && parent.nodeName != "BODY") {
            parent = parent.parentNode;
        }
        return parent.id;
    },
    showDropDown: function(result) {
        if (result.html) {
            newdiv = document.createElement("div");
            newdiv.className = "selectorChildContainer";
            newdiv.innerHTML = result.html;
            this.current.parentNode.appendChild(newdiv);
        }

        //$(this.id + "Indicator").style.display = "none";   
        lara.indicateOff();
        this.disableSelectors(false);
    },
    disableSelectors: function(disabled) {
        var selectors = $getByClass("selector", "select");
        for (var i = 0; i < selectors.length; i++) {
            selectors[i].disabled = disabled;
        }
    }
};

var selector = new geoSelector();function geoUI() {  };

geoUI.prototype = {
    init: function () {
        //this.explore();
        this.initSubs();
    },
    disable: function () {
        this.disableExplore();
        this.disableSubs();
    },
    showTab: function (TabSet, ShowOption) {
        var TabSetContent = $(TabSet).getElementsByTagName("div");
        var TabSetTabs = $(TabSet).getElementsByTagName("a");
        for (var i = 0; i < TabSetTabs.length; i++) {
            if (TabSetTabs[i].className == "AdminTabSelected") {
                TabSetTabs[i].className = "AdminTab";
                break;
            }
            if (TabSetTabs[i].className == "OpenAdminTabSelected") {
                TabSetTabs[i].className = "OpenAdminTab";
                break;
            }
            if (TabSetTabs[i].className == "ShortAdminTabSelected") {
                TabSetTabs[i].className = "ShortAdminTab";
                break;
            }
        }

        for (var i = 0; i < TabSetContent.length; i++) {
            var CurDiv = TabSetContent[i];
            if (CurDiv.id) {
                if (CurDiv.id.indexOf("TabContent") >= 0)
                    CurDiv.style.display = "none";
            }
        }
        if ($(TabSet + "Tab" + ShowOption).className == "AdminTab")
            $(TabSet + "Tab" + ShowOption).className = "AdminTabSelected";
        if ($(TabSet + "Tab" + ShowOption).className == "ShortAdminTab")
            $(TabSet + "Tab" + ShowOption).className = "ShortAdminTabSelected";
        if ($(TabSet + "Tab" + ShowOption).className == "OpenAdminTab")
            $(TabSet + "Tab" + ShowOption).className = "OpenAdminTabSelected";
        $(TabSet + "TabContent" + ShowOption).style.display = "block";
    },
    initSubs: function () {

        //add mouse over events for drop downs
        var mainItems = $getByClass("HasSubMenu", "li");
        for (var i = 0; i < mainItems.length; i++) {
            var link = mainItems[i].getElementsByTagName("a")[0];
            link.onmouseover = function (ev) { ui.showSubMenu(this, "Sub" + this.parentNode.id); };
        }
        var topItems = $getByClass("THasSubMenu", "li");
        for (var i = 0; i < topItems.length; i++) {
            var link = topItems[i].getElementsByTagName("a")[0];
            link.onmouseover = function (ev) { ui.showSubMenu(this, "Sub" + this.parentNode.id); };
        }
    },
    disableSubs: function () {

        //add mouse over events for drop downs
        var mainItems = $getByClass("HasSubMenu", "li");
        for (var i = 0; i < mainItems.length; i++) {
            mainItems[i].firstChild.onmouseover = null;
        }
        var topItems = $getByClass("THasSubMenu", "li");
        for (var i = 0; i < topItems.length; i++) {
            topItems[i].firstChild.onmouseover = null;
        }
    },
    showSubMenu: function (menuItem, subMenuId) {

        //prevent duplicate mouseover events (speaking menus)
        if (menuItem == this.openSubItem) return;

        if (!lara.ready) return;

        //Close already open sub menus.
        if (this.openSubMenu) {
            if (this.openSubMenu.shim) {
                tvv.removeShim(this.openSubMenu.shim);
                this.openSubMenu.shim = null;
            }

            this.openSubMenu.style.display = "none";
            document.onmousemove = null;
        }

        if (document.onmousemove) return false;

        var pos = ui.findPos(menuItem);
        var subMenu = $(subMenuId);
        subMenu.parentNode.removeChild(subMenu);
        document.body.appendChild(subMenu);
        subMenu.style.position = "absolute";

        var subPosLeft = pos.x;
        var subPosTop = pos.y;

        var menuParent = menuItem.parentNode.parentNode.parentNode.parentNode; //a-li-ul-mainmenu-menu

        var floatDir;
        if (window.getComputedStyle)
            floatDir = window.getComputedStyle(menuParent, null).cssFloat;
        else if (menuParent.currentStyle) //ie
            floatDir = menuParent.currentStyle.styleFloat;

        //flyright
        if (floatDir == "left") {
            subPosLeft += menuItem.offsetWidth;
            subMenu.style.width = menuItem.offsetWidth;
        }
        //flyleft
        else if (floatDir == "right") {
            subMenu.style.display = "block";
            subMenu.style.width = menuItem.offsetWidth;
            subPosLeft -= subMenu.offsetWidth;

        }
        else {
            subPosTop += menuItem.offsetHeight;
        }

        subMenu.style.left = subPosLeft + "px";
        subMenu.style.top = subPosTop + "px";
        subMenu.style.display = "block";

//        if (tvv) {
//            subMenu.shim = tvv.addShim(subMenu);
//            tvv.resizeShims();
//            subMenu.shim.style.display = "block";
//        }

        this.openSubMenu = subMenu;
        this.openSubItem = menuItem;

        var subPos = ui.findPos(subMenu);
        var fuzz = 20;
        this.validBox1 = { x: pos.x - fuzz, y: pos.y - fuzz, height: menuItem.offsetHeight + fuzz + fuzz, width: menuItem.offsetWidth + fuzz + fuzz };
        this.validBox2 = { x: subPos.x - fuzz, y: subPos.y - fuzz, height: subMenu.offsetHeight + fuzz + fuzz, width: subMenu.offsetWidth + fuzz + fuzz };
        document.onmousemove = function (ev) { ui.checkMousePos(ev); };



    },
    checkMousePos: function (ev) {
        ev = ev || window.event;
        var mousePos = dragdrop.mousePos(ev);

        if (!(this.inBox(mousePos, this.validBox1) || this.inBox(mousePos, this.validBox2))) {
            document.onmousemove = null;
            if (this.openSubMenu) {
                if (this.openSubMenu.shim) {
                    tvv.removeShim(this.openSubMenu.shim);
                    this.openSubMenu.shim = null;
                }

                this.openSubMenu.style.display = "none";
                this.openSubItem = null;
            }
        }
    },
    inBox: function (mousePos, validBox) {
        if (mousePos.x < (validBox.x + validBox.width) && mousePos.x > validBox.x) {
            if (mousePos.y < (validBox.y + validBox.height) && mousePos.y > validBox.y)
                return true;
        }
    },
    selectText: function (elem) {
        if (document.selection) {
            var r1 = document.body.createTextRange();
            r1.moveToElementText(elem);
            r1.setEndPoint("EndToEnd", r1);
            r1.select();
        } else {
            s = window.getSelection();
            var r1 = document.createRange();
            r1.setStartBefore(elem);
            r1.setEndAfter(elem);
            s.addRange(r1);
        }
    },
    centerElement: function (id) {
        $(id).style.top = (document.documentElement.clientHeight - $(id).offsetHeight) / 2 + lara.scrollTop() + "px";
        $(id).style.left = (document.documentElement.clientWidth - $(id).offsetWidth) / 2 + lara.scrollLeft() + "px";
    },
    explore: function () {
        var Items = $getByClass("ExploreItem", "div");
        for (var i = 0; i < Items.length; i++) {
            var Item = Items[i];
            Item.onmouseover = function (ev) {
                var Data = $(this.id + "Data");
                Data.style.position = "absolute";
                ui.exploreData = Data;
                document.onmousemove = function (ev) { ui.showExploreData(ev); };
                return false;
            };
            Item.onmouseout = function (ev) {
                ui.exploreData.style.display = "none";
                ui.exploreData = null;
                document.onmousemove = null;
                return false;
            };
        }
    },
    disableExplore: function () {
        var Items = $getByClass("ExploreItem", "div");
        for (var i = 0; i < Items.length; i++) {
            var Item = Items[i];
            Item.onmouseover = null;
            Item.onmouseout = null;
        }
    },
    showExploreData: function (ev) {
        ev = ev || window.event;
        var mousePos = dragdrop.mousePos(ev);
        if (ui.exploreData != null) {
            if (mousePos.x > (document.body.clientWidth - 350))
                ui.exploreData.style.left = (mousePos.x - 385) + "px";
            else
                ui.exploreData.style.left = (mousePos.x + 20) + "px";

            ui.exploreData.style.top = (mousePos.y - 50) + "px";
            ui.exploreData.style.display = "block";
        }
    },
    showLarge: function (displayUrl, imageURI) {
        this.hideDisplayImage();
        var showImage = document.createElement("img");
        showImage.id = "ShowDisplayImage";
        showImage.className = "Display";
        showImage.title = "Click to close.";
        showImage.style.position = "absolute";
        var left = ((document.documentElement.clientWidth - 480) / 2) + lara.scrollLeft();
        var top = ((document.documentElement.clientHeight - 320) / 2) + lara.scrollTop();
        showImage.style.left = left + "px";
        showImage.style.top = top + "px";
        showImage.src = displayUrl;

        if (typeof document.addEventListener == "function") {
            showImage.addEventListener("click", function () { ui.hideDisplayImage(); }, false);
        }
        else {
            showImage.attachEvent("onclick", function () { ui.hideDisplayImage(); });
        }

        document.body.appendChild(showImage);
    },
    hideDisplayImage: function () {
        var ShowImage = $("ShowDisplayImage");
        if (ShowImage)
            document.body.removeChild(ShowImage);
    },
    showPic: function (listindex, Pic) {
        var PicType = $("PicType" + listindex + Pic).value;

        var Size = "Display";
        if ($("PicViewDisplay" + listindex + Pic).value.indexOf("-s") >= 0)
            Size = "Snap";

        if (PicType == "Image") {
            var PicView = null;
            if ($("PicViewFeatured" + listindex))
                PicView = $("PicViewFeatured" + listindex);
            else {
                PicView = document.createElement("img");
                PicView.id = "PicViewFeatured" + listindex;
                PicView.className = Size;
                $("FeaturedViewer" + listindex).replaceChild(PicView, $("ShowPlayer" + listindex));
            }
            PicView.src = BASE_URL + "/_ui/css/img/admin/libraryindicator.gif";
            PicView.src = $("PicViewDisplay" + listindex + Pic).value;
            if (Size == "Snap") {
                var DisplayUrl = $("PicViewDisplay" + listindex + Pic).value.replace("-s", "-d");
                PicView.onclick = function () { ui.showLarge(DisplayUrl, 'Pic'); };
            }
        }
        else if (PicType == "Video" || PicType == "Audio") //Video/audio
        {
            if (!$("ShowPlayer" + listindex)) {
                var Player = document.createElement("div");
                Player.innerHTML = "<a href=\"http://www.macromedia.com/go/getflashplayer\">Install Flash Player</a> to view this video.";
                Player.id = "ShowPlayer" + listindex;
                $("FeaturedViewer" + listindex).replaceChild(Player, $("PicViewFeatured" + listindex));
            }
            var s1;
            if (Size == "Display") {
                s1 = new SWFObject(BASE_URL + "/_ui/flash/flvplayer.swf", "single", "480", "380", "7");
                s1.addVariable("width", "480");
                s1.addVariable("height", "380");
            }
            else {
                var s1 = new SWFObject(BASE_URL + "/_ui/flash/flvplayer.swf", "single", "200", "170", "7");
                s1.addVariable("width", "200");
                s1.addVariable("height", "170");
            }
            s1.addParam("wmode", "transparent");
            s1.addVariable("file", $("PicVideo" + listindex + Pic).value);
            s1.addVariable("image", $("PicViewDisplay" + listindex + Pic).value);
            s1.write("ShowPlayer" + listindex);
        }

        var OldPic = $("PicViewCurrent" + listindex).innerHTML;
        $("PicViewCurrent" + listindex).innerHTML = Pic;

        if ($("PicView" + listindex + OldPic)) {
            $("PicView" + listindex + OldPic).className = "CutThumb";
            $("PicView" + listindex + Pic).className = "CutThumbSelected";
        }
    },
    picNext: function (listindex) {
        var Count = parseInt($("PicViewCount" + listindex).innerHTML);
        var OldPic = parseInt($("PicViewCurrent" + listindex).innerHTML);
        OldPic++;
        if (OldPic <= Count)
            this.showPic(listindex, OldPic);
        else
            this.showPic(listindex, 1);
    },
    picPrev: function (listindex) {
        var Count = parseInt($("PicViewCount" + listindex).innerHTML);
        var OldPic = parseInt($("PicViewCurrent" + listindex).innerHTML);
        OldPic--;
        if (OldPic >= 1)
            this.showPic(listindex, OldPic);
        else
            this.showPic(listindex, Count);

    },
    readDate: function (SelectorId) {
        return $(SelectorId + "Day").value + " " + $(SelectorId + "Month").value + " " + $(SelectorId + "Year").value;
    },
    findPos: function (obj) {
        var curleft = curtop = 0;
        if (obj.offsetParent) {
            curleft = obj.offsetLeft;
            curtop = obj.offsetTop;
            while (obj = obj.offsetParent) {
                curleft += obj.offsetLeft;
                curtop += obj.offsetTop;
            }
        }
        return { x: curleft, y: curtop };
    },
    disableSelection: function () {
        var target = document.body;
        if (typeof target.onselectstart != "undefined") //IE route
            target.onselectstart = function () { return false; };
        else if (typeof target.style.MozUserSelect != "undefined") //Firefox route
            target.style.MozUserSelect = "none";
        else
            target.onmousedown = function () { return false; };
        target.style.cursor = "default";
    },
    enableSelection: function () {
        var target = document.body;
        if (typeof target.onselectstart != "undefined") //IE route
            target.onselectstart = null;
        else if (typeof target.style.MozUserSelect != "undefined") //Firefox route
            target.style.MozUserSelect = "";
        else
            target.onmousedown = null;
        target.style.cursor = "default";
    },
    showCaptcha: function () {
        Recaptcha.create("6Le7NLoSAAAAAJM6f84OdgdgqiXyVnaNasdQi2WJ",
             "recaptcha_div", {
                 theme: "white",
                 callback: Recaptcha.focus_response_field
             });
    }
};
var ui = new geoUI();

function slideshow() { };

slideshow.prototype = {
    init: function(id, delay) {
        slideshows[id] = this;
        this.delay = delay;
        this.imgs = new Array();
        this.current = 0;
        this.imgs = $(id).getElementsByTagName("img");
        for (i = 1; i < this.imgs.length; i++) {
            this.imgs[i].xOpacity = 0;
        }
        this.imgs[0].style.display = "block";
        this.imgs[0].xOpacity = .99;

        setTimeout(function() { slideshows[id].fade(id); }, this.delay);
    },
    fade: function(id) {

        cOpacity = this.imgs[this.current].xOpacity;
        nIndex = this.imgs[this.current + 1] ? this.current + 1 : 0;
        nOpacity = this.imgs[nIndex].xOpacity;

        cOpacity -= .05;
        nOpacity += .05;

        this.imgs[nIndex].style.display = "block";
        this.imgs[this.current].xOpacity = cOpacity;
        this.imgs[nIndex].xOpacity = nOpacity;

        this.setOpacity(this.imgs[this.current]);
        this.setOpacity(this.imgs[nIndex]);

        if (cOpacity <= 0) {
            this.imgs[this.current].style.display = "none";
            this.current = nIndex;
            setTimeout(function() { slideshows[id].fade(id); }, this.delay);
        } else {
            setTimeout(function() { slideshows[id].fade(id); }, 50);
        }
    },
    setOpacity: function(obj) {
        if (obj.xOpacity > .99) {
            obj.xOpacity = .99;
            return;
        }
        obj.style.opacity = obj.xOpacity;
        obj.style.MozOpacity = obj.xOpacity;
        obj.style.filter = "alpha(opacity=" + (obj.xOpacity * 100) + ")";
    }
}
var slideshows = new Array();


//function FadeOut(Node, Op)
//{
//    Op = Op - 20;
//	Node.style.opacity = Op/100;
//	Node.style.filter = 'alpha(opacity=' + Op + ')';
//    
//    if (Op > 0)
//        setTimeout(function() { FadeOut(Node, Op); }, 10); 
//    else
//        Node.style.display = "none";
//}
//function FadeIn(Node, Op)
//{
//    Op = Op + 20;
//    Node.style.display = "block";
//	Node.style.opacity = Op/100;
//	Node.style.filter = 'alpha(opacity=' + Op + ')';

//    if (Op < 100)
//        setTimeout(function() { FadeIn(Node, Op); }, 10); 
//}




var VERSION = "3.70";
var BASE_URL = window.location.protocol + "//" + window.location.host;
//if (BASE_URL.indexOf("localhost") >= 0)
//    BASE_URL += "/lara";
    
//Geo
function laraFrame() {  };

laraFrame.prototype = {
    init: function() {

        this.indicator = $("Indicator");
        this.adScreens = $("AdminScreens");
        this.ready = true;
        this.hasFocus = true;
        window.onblur = function() { lara.lostFocus(); };
        window.onfocus = function() { lara.gainFocus(); };
    },
    screens: [],
    windows: [],
    loadScreen: function(id, path) {
        if (this.screens[id]) { this.screens[id].setFocus(); return; }
        this.screens[id] = new geoScreen(id, path);
    },
    loadWindow: function(config, parameters, width) {
        if (this.windows[config.id]) { this.windows[config.id].show(); return; }
        if (!parameters)
            parameters = "";

        if (width)
            config.width = width;

        this.windows[config.id] = new geoWindow(config, parameters);
    },
    loadLibrary: function(selectAction, target, callback) {

        admin.close(MEDIA_LIBRARY);
        lara.loadWindow(MEDIA_LIBRARY, '?mode=select&selectaction=' + selectAction + '&target=' + target); //&method=' + callback);
    },
    indicateOn: function() {

        if (!this.indicator)
            return;

        //make sure indicator is on top by removing and adding (firefox)
        this.indicator.parentNode.removeChild(this.indicator);
        document.body.appendChild(this.indicator);

        //Position indicator in the middle of the current screen.
        this.indicator.style.top = (document.documentElement.clientHeight - 64) / 2 + this.scrollTop() + "px";
        this.indicator.style.left = (document.documentElement.clientWidth - 64) / 2 + this.scrollLeft() + "px";
        this.indicator.style.display = "block";
    },
    indicateOff: function() {
        if (!this.indicator)
            return;
        this.indicator.style.display = "none"; 
    },
    scrollTop: function() {

        if (document.documentElement.scrollTop)
            return document.documentElement.scrollTop;
        else if (document.body.scrollTop)
            return document.body.scrollTop;
        else
            return 0;

    },
    scrollLeft: function() {
        if (document.documentElement.scrollLeft)
            return document.documentElement.scrollLeft;
        else if (document.body.scrollLeft)
            return document.body.scrollLeft;
        else
            return 0;

    },
    request: function(target, dataObject, callback, isHtml, assembly, object) {
        var reqObject = new lrequest();
        reqObject.request(target, dataObject, callback, isHtml, assembly, object);
    },
    include: function(filename) {
        if (BASE_URL.indexOf("localhost") >= 0)
            VERSION = Date();
        filename += "?version=" + VERSION;
        if (!this.included(filename, "script")) {
            var head = $get("head").item(0);
            var file = $new("script");
            file.setAttribute("language", "javascript");
            file.setAttribute("type", "text/javascript");
            file.setAttribute("src", filename);
            head.appendChild(file);
        }
    },
    included: function(filename, type) {
        var files = $get(type);
        for (var i = 0; i < files.length; i++) {
            if (type == "script")
                if (files[i].src == filename)
                return true;
            else
                if (files[i].href == filename)
                return true;
        }
        return false;
    },
    exclude: function(filename) {
        filename += "?version=" + VERSION;
        var script = null;
        var scripts = $get("script");
        for (var i = 0; i < scripts.length; i++) {
            if (scripts[i].src == filename) {
                script = scripts[i];
                break;
            }
        }
        if (script != null) {
            script.parentNode.removeChild(script);
        }
    },
    moveWindows: function() {
        for (var i = 0; i < this.windows.length; i++) {
            if (this.windows[i] != null) {
                this.windows[i].move();
            }
        }
    },
    authenticate: function() {
        if ($("UserName").value == "" || $("Password").value == "") {
            return false;
        }
        lara.indicateOn();
        var data = new dataObject();
        data.add("UserName", $("UserName").value);
        data.add("Password", $("Password").value);
        data.add("Remember", $("RememberMe").checked);

        $("SignInButton").disabled = true;
        lara.request(SIGN_IN.path + ":Authenticate", data, function(result) { lara.processSignIn(result); });
    },
    processSignIn: function(result) {
        if (result.success) {
            window.location.reload();
        }
        else {
            $("SignInStatus").innerHTML = result.error;
            $("SignInButton").disabled = false;
            lara.indicateOff();
        }
    },
    signOut: function() {
        lara.indicateOn();
        lara.request(SIGN_IN.path + ":SignOut", null, function(result) { lara.processSignOut(result); });
    },
    processSignOut: function(result) {
        if (result.success)
            window.location.reload(); // window.location.href.replace(/\/_admin/g, "");
        else
            alert(result.error);

        lara.indicateOff();
    },
    hide: function(config) {
        if (this.windows[config.id])
            this.windows[config.id].hide();
    },
    close: function(config) {
        if (this.windows[config.id])
            this.windows[config.id].close();
        if (this.screens[config])
            this.screens[config].close();
    },
    //Used to add scripts to a page which were referenced inside the page. VERIFY WORKING PROPERLY 
    refreshScripts: function(target) {
        var scripts = target.getElementsByTagName("script");
        var newNodes = new Array();
        var replaceNodes = new Array();
        for (var i = 0; i < scripts.length; i++) {
            var script = $new("script");
            script.setAttribute("language", "javascript");
            script.setAttribute("type", "text/javascript");

            if (scripts[i].innerHTML == "") {
                if (scripts[i].src) {
                    script.setAttribute("src", scripts[i].src);
                }
            }
            replaceNodes.push(scripts[i]);
            newNodes.push(script);
        }
        for (var i = 0; i < replaceNodes.length; i++) {
            replaceNodes[i].parentNode.replaceChild(newNodes[i], replaceNodes[i]);
        }
    },
    lostFocus: function() {
        this.hasFocus = false;
    },
    gainFocus: function() {
        this.hasFocus = true;
    }
};

//Request object for handling multiple simultaneous xhr requests, a new object is created for each request
function lrequest() {};
lrequest.prototype = {
    getRequestObject: function () {
        if (window.XMLHttpRequest) { return new XMLHttpRequest(); }
        else if (window.ActiveXObject) { return new ActiveXObject("Microsoft.XMLHTTP"); } //ie
    },
    request: function (target, dataObject, callback, isHtml, assembly, object) {
        var self = this;
        this.isHtml = isHtml;
        if (!isHtml) {
            if (target.indexOf(":") >= 0)
                target = target.replace(":", "?method=") + "&type=get";
            else
                target = target + "?method=ProcessRequest&type=get";
        }
        if (assembly)
            target += "&assembly=" + assembly + "&object=" + object;

        this.callback = callback;
        this.req = this.getRequestObject();
        this.req.onreadystatechange = function () { self.processRequest(); };

        this.req.open("POST", BASE_URL + target, true);
        var data = "";
        if (dataObject) {
            if (dataObject.data)
                data = dataObject.serialize();
            else
                data = dataObject;
        }
        this.req.send(data);
    },
    processRequest: function () {
        if (this.req.readyState == 4) {
            if (this.req.status == 200) {
                if (this.isHtml)
                    this.callback.call(this, this.req.responseText); //html
                else
                    this.callback.call(this, eval('(' + this.req.responseText + ')')); //json
            }
            else {
                var result = { success: false, error: "Communication or server error: " + this.req.status + ".  Details: " + this.req.responseText };
                this.callback.call(this, result); //json
            }
        }
    }
};

function dataObject() {}
dataObject.prototype = {
    data: "",
    add: function(name, value) {
        value = value + ""; //ensure its a string
        this.data += "&" + name.replace(/&/g, "|||").replace(/=/g, ":::") + "=" + value.replace(/&/g, "|||").replace(/=/g, ":::");
    },
    serialize: function(){
        return this.data.substring(1);
    }
};


//Plugin Callbacks
function pluginAction() { };

pluginAction.prototype = {
    serverPath: "/_ui/plugin",
    request: function(id, locator, targetId, path, hide) {

        if (hide && $(targetId).innerHTML != "") {
            $(targetId).innerHTML = "";
            return;
        }

        var data = new dataObject();
        data.add("id", id);
        data.add("locator", locator);
        data.add("targetId", targetId);
        data.add("path", path);

        lara.indicateOn();
        lara.request(this.serverPath + ":RequestData", data, function(result) { plugin.showResult(result); });
    },
    showResult: function(result) {
        if (result.html) {
            $(result.targetId).innerHTML = result.html;
        }
        else {
            alert(result.error);
        }
        lara.indicateOff();
    }
};

var plugin = new pluginAction();

//Table object for easy rendering of tables with javascript
function ltable() { 
    this.table = $new("table");  
    this.table.cellSpacing = 0;
    this.table.cellPadding = 0;
    this.table.className = "CleanTable";
    this.tbody = $new("tbody");
    this.table.appendChild(this.tbody);
};
ltable.prototype = {
    newRow: function() {
        var row = $new("tr");
        this.tbody.appendChild(row);
        this.currentRow = row;
    },
    newCell: function(className) {
        var cell = $new("td");
        if (className)
            cell.className = className;
        this.currentRow.appendChild(cell);
        this.currentCell = cell;
    },
    append: function(element) {
        this.currentCell.appendChild(element);
    }
};
function $link(id, className, text, onclick) { 
    var link = $new("a");  
    link.id = id;
    link.className = "aaa " + className;
    var span = $new("span");
    span.innerHTML = text;
    link.appendChild(span);
    link.onclick = onclick;
    return link;
};

function $(id) {
    return document.getElementById(id);
};
function $new(tagName){
    return document.createElement(tagName);
};
function $text(text){
    return document.createTextNode(text);
};
function $get(tagName) {
    return document.getElementsByTagName(tagName);
};
function trim(str) {
    return str.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
} 
function $getByClass(className, tag, elm){
	var tag = tag || "*";
	var elm = elm || document;
	var elements = (tag == "*" && elm.all)? elm.all : elm.getElementsByTagName(tag);
	var returnElements = [];
	var length = elements.length;
	for(var i=0; i<length; i++){
		if(elements[i].className.indexOf(className)>=0){
			returnElements.push(elements[i]);
		}
	}
	return returnElements;
};
var lara = new laraFrame();

function checkReady()
{
    if (document.addEventListener) { document.addEventListener("DOMContentLoaded", setDOMReady, false); } //Firefox
    if (document.all && !window.opera) { //IE
        var proto = "src='javascript:void(0)'";
        if (location.protocol == "https:") proto = "src=//:";
        document.write("<scr" + "ipt id=__ie_onload defer " + proto + "><\/scr" + "ipt>");
        var contentloadtag = $("__ie_onload");
        contentloadtag.onreadystatechange = function() { if (this.readyState == "complete") { setDOMReady(); } };
    }
    if(/Safari/i.test(navigator.userAgent)) //Safari
    { 
      var _timer=setInterval(function()
                              {
                                  if(/loaded|complete/.test(document.readyState))
                                  {
                                    clearInterval(_timer);
                                    setDOMReady(); // call target function
                                  }
                              }, 10);
    }    
}; 
function setDOMReady()
{
    lara.init();
    try { admin.init(); } catch(err){}
    try { ui.init(); } catch(err){}
    //try { chat.init(); } catch (err) { }

//    if (!$("AdminToolbar")) {
//        //if (BASE_URL.indexOf("localhost")>=0) {
//        if (BASE_URL == "http://templates.csslara.com") {
//            design.panel = $("AdminPanel");
//            design.load(true);
//        }
//    }
   
};

checkReady();


/**
 * SWFObject v1.5: Flash Player detection and embed - http://blog.deconcept.com/swfobject/
 *
 * SWFObject is (c) 2007 Geoff Stearns and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 *
 */
if(typeof deconcept=="undefined"){var deconcept=new Object();}if(typeof deconcept.util=="undefined"){deconcept.util=new Object();}if(typeof deconcept.SWFObjectUtil=="undefined"){deconcept.SWFObjectUtil=new Object();}deconcept.SWFObject=function(_1,id,w,h,_5,c,_7,_8,_9,_a){if(!document.getElementById){return;}this.DETECT_KEY=_a?_a:"detectflash";this.skipDetect=deconcept.util.getRequestParameter(this.DETECT_KEY);this.params=new Object();this.variables=new Object();this.attributes=new Array();if(_1){this.setAttribute("swf",_1);}if(id){this.setAttribute("id",id);}if(w){this.setAttribute("width",w);}if(h){this.setAttribute("height",h);}if(_5){this.setAttribute("version",new deconcept.PlayerVersion(_5.toString().split(".")));}this.installedVer=deconcept.SWFObjectUtil.getPlayerVersion();if(!window.opera&&document.all&&this.installedVer.major>7){deconcept.SWFObject.doPrepUnload=true;}if(c){this.addParam("bgcolor",c);}var q=_7?_7:"high";this.addParam("quality",q);this.setAttribute("useExpressInstall",false);this.setAttribute("doExpressInstall",false);var _c=(_8)?_8:window.location;this.setAttribute("xiRedirectUrl",_c);this.setAttribute("redirectUrl","");if(_9){this.setAttribute("redirectUrl",_9);}};deconcept.SWFObject.prototype={useExpressInstall:function(_d){this.xiSWFPath=!_d?"expressinstall.swf":_d;this.setAttribute("useExpressInstall",true);},setAttribute:function(_e,_f){this.attributes[_e]=_f;},getAttribute:function(_10){return this.attributes[_10];},addParam:function(_11,_12){this.params[_11]=_12;},getParams:function(){return this.params;},addVariable:function(_13,_14){this.variables[_13]=_14;},getVariable:function(_15){return this.variables[_15];},getVariables:function(){return this.variables;},getVariablePairs:function(){var _16=new Array();var key;var _18=this.getVariables();for(key in _18){_16[_16.length]=key+"="+_18[key];}return _16;},getSWFHTML:function(){var _19="";if(navigator.plugins&&navigator.mimeTypes&&navigator.mimeTypes.length){if(this.getAttribute("doExpressInstall")){this.addVariable("MMplayerType","PlugIn");this.setAttribute("swf",this.xiSWFPath);}_19="<embed type=\"application/x-shockwave-flash\" src=\""+this.getAttribute("swf")+"\" width=\""+this.getAttribute("width")+"\" height=\""+this.getAttribute("height")+"\" style=\""+this.getAttribute("style")+"\"";_19+=" id=\""+this.getAttribute("id")+"\" name=\""+this.getAttribute("id")+"\" ";var _1a=this.getParams();for(var key in _1a){_19+=[key]+"=\""+_1a[key]+"\" ";}var _1c=this.getVariablePairs().join("&");if(_1c.length>0){_19+="flashvars=\""+_1c+"\"";}_19+="/>";}else{if(this.getAttribute("doExpressInstall")){this.addVariable("MMplayerType","ActiveX");this.setAttribute("swf",this.xiSWFPath);}_19="<object id=\""+this.getAttribute("id")+"\" classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" width=\""+this.getAttribute("width")+"\" height=\""+this.getAttribute("height")+"\" style=\""+this.getAttribute("style")+"\">";_19+="<param name=\"movie\" value=\""+this.getAttribute("swf")+"\" />";var _1d=this.getParams();for(var key in _1d){_19+="<param name=\""+key+"\" value=\""+_1d[key]+"\" />";}var _1f=this.getVariablePairs().join("&");if(_1f.length>0){_19+="<param name=\"flashvars\" value=\""+_1f+"\" />";}_19+="</object>";}return _19;},write:function(_20){if(this.getAttribute("useExpressInstall")){var _21=new deconcept.PlayerVersion([6,0,65]);if(this.installedVer.versionIsValid(_21)&&!this.installedVer.versionIsValid(this.getAttribute("version"))){this.setAttribute("doExpressInstall",true);this.addVariable("MMredirectURL",escape(this.getAttribute("xiRedirectUrl")));document.title=document.title.slice(0,47)+" - Flash Player Installation";this.addVariable("MMdoctitle",document.title);}}if(this.skipDetect||this.getAttribute("doExpressInstall")||this.installedVer.versionIsValid(this.getAttribute("version"))){var n=(typeof _20=="string")?document.getElementById(_20):_20;n.innerHTML=this.getSWFHTML();return true;}else{if(this.getAttribute("redirectUrl")!=""){document.location.replace(this.getAttribute("redirectUrl"));}}return false;}};deconcept.SWFObjectUtil.getPlayerVersion=function(){var _23=new deconcept.PlayerVersion([0,0,0]);if(navigator.plugins&&navigator.mimeTypes.length){var x=navigator.plugins["Shockwave Flash"];if(x&&x.description){_23=new deconcept.PlayerVersion(x.description.replace(/([a-zA-Z]|\s)+/,"").replace(/(\s+r|\s+b[0-9]+)/,".").split("."));}}else{if(navigator.userAgent&&navigator.userAgent.indexOf("Windows CE")>=0){var axo=1;var _26=3;while(axo){try{_26++;axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash."+_26);_23=new deconcept.PlayerVersion([_26,0,0]);}catch(e){axo=null;}}}else{try{var axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash.7");}catch(e){try{var axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash.6");_23=new deconcept.PlayerVersion([6,0,21]);axo.AllowScriptAccess="always";}catch(e){if(_23.major==6){return _23;}}try{axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash");}catch(e){}}if(axo!=null){_23=new deconcept.PlayerVersion(axo.GetVariable("$version").split(" ")[1].split(","));}}}return _23;};deconcept.PlayerVersion=function(_29){this.major=_29[0]!=null?parseInt(_29[0]):0;this.minor=_29[1]!=null?parseInt(_29[1]):0;this.rev=_29[2]!=null?parseInt(_29[2]):0;};deconcept.PlayerVersion.prototype.versionIsValid=function(fv){if(this.major<fv.major){return false;}if(this.major>fv.major){return true;}if(this.minor<fv.minor){return false;}if(this.minor>fv.minor){return true;}if(this.rev<fv.rev){return false;}return true;};deconcept.util={getRequestParameter:function(_2b){var q=document.location.search||document.location.hash;if(_2b==null){return q;}if(q){var _2d=q.substring(1).split("&");for(var i=0;i<_2d.length;i++){if(_2d[i].substring(0,_2d[i].indexOf("="))==_2b){return _2d[i].substring((_2d[i].indexOf("=")+1));}}}return "";}};deconcept.SWFObjectUtil.cleanupSWFs=function(){var _2f=document.getElementsByTagName("OBJECT");for(var i=_2f.length-1;i>=0;i--){_2f[i].style.display="none";for(var x in _2f[i]){if(typeof _2f[i][x]=="function"){_2f[i][x]=function(){};}}}};if(deconcept.SWFObject.doPrepUnload){if(!deconcept.unloadSet){deconcept.SWFObjectUtil.prepUnload=function(){__flash_unloadHandler=function(){};__flash_savedUnloadHandler=function(){};window.attachEvent("onunload",deconcept.SWFObjectUtil.cleanupSWFs);};window.attachEvent("onbeforeunload",deconcept.SWFObjectUtil.prepUnload);deconcept.unloadSet=true;}}if(!document.getElementById&&document.all){document.getElementById=function(id){return document.all[id];};}var getQueryParamValue=deconcept.util.getRequestParameter;var FlashObject=deconcept.SWFObject;var SWFObject=deconcept.SWFObject;