# project2.cards
Initial route plan

routes						
user action	        browser control	        HTTP Method 	path    	    CRUD    	SQL	        Template
go to home page	    address bar	            get	            /	            read        select	    index
						
create card form	link	                get	            /               cards/new	read		create_new_card
create card	        form	                post	        /cards	        create	    insert	    redirect
go to single cards	link	                get	            /card/:id	    read	    select	    show_card
edit card       	link	                get	            /card/:id/edit	update	    update	    edit_card_form
update card	        form	                put	            /card/:id	    update	    update  	redirect
delete card	        form	                delete      	/card:id	    delete	    delete  	redirect
						
list of all cards	link	                get	            /cards	        read	    select	    index