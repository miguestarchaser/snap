local widget = require( "widget" )
local photo  = {};

-- Function to handle button events


-- Create the widget
local widget = require( "widget" )

-- Function to handle button events
local function handleButtonEvent( event )

    if ( "ended" == event.phase ) then
        print( "Button was pressed and released" )
        if media.hasSource( media.PhotoLibrary ) then
		   print("seleccionar foto");
		    media.selectPhoto( 
               {
                    mediaSource = media.PhotoLibrary,
                    listener = subirfoto, --completePhoto, 
                    --origin = cameraBtn.contentBounds, 
                    --permittedArrowDirections = { "up", "down" }, 
                    destination = {baseDir=system.DocumentsDirectory, filename="uploadtemp.jpg",type="image"} 
                } 
                )
			print("esperando al listener")
		else
		   native.showAlert( "Corona", "This device does not have a photo library.", { "OK" } )
		end
    end
end

-- Create the widget
local button1 = widget.newButton(
    {
        label = "button",
        onEvent = handleButtonEvent,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        width = 200,
        height = 40,
        cornerRadius = 2,
        fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
        strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
        strokeWidth = 4
    }
)

-- Center the button
button1.x = display.contentCenterX
button1.y = display.contentCenterY

-- Change the button's label text
--button1:setLabel( "Shape" )

--funciones--




function subirfoto( event )
   --	print(event.destination);
   	print("listo para subir")
   	local photo = event.target
   	--print( "photo w,h = " .. photo.width .. "," .. photo.height )
   	--print(photo.mediaSource)
   	--print(photo.filename)
   	--print(photo.fileName)
   	--print(photo.Name)
   	local url = "http://api.wayakstudios.com/index.php/main/corona"
	local method = "PUT"
 	print(url)
 	print(method)
 	--print_array(photo)
	local filename = "uploadtemp.jpg"
	local baseDirectory = system.DocumentsDirectory;
	print(filename);
	print(baseDirectory);
	local params = {
	   timeout = 60,
	   progress = true,
	   bodyType = "binary"
	}
	local contentType = "image/jpeg" 
	local headers = {}
	headers.filename = filename
	params.headers = headers
 
	network.upload( url , method, uploadListener, params, filename, baseDirectory, contentType )
 
end

function print_array(array)
	if(type (array)=="table") then
		for k,v in pairs(array) do
			if(type(v) == "table") then
				print_array(v)
			else
				print("["..k.."]=>");
				print(v);
			end	
		end	
	else 
		print(array);
	end	
end

function uploadListener( event )
   print(event);
   if ( event.isError ) then
      print( "Network Error." )
 
      -- This is likely a time out or server being down. In other words,
      -- It was unable to communicate with the web server. Now if the
      -- connection to the web server worked, but the request is bad, this
      -- will be false and you need to look at event.status and event.response
      -- to see why the web server failed to do what you want.
   else
      if ( event.phase == "began" ) then
         print( "Upload started" )
      elseif ( event.phase == "progress" ) then
         print( "Uploading... bytes transferred ", event.bytesTransferred )
      elseif ( event.phase == "ended" ) then
         print( "Upload ended..." )
         print( "Status:", event.status )
         print( "Response:", event.response )
         local alert = native.showAlert( "Corona", "Dream. Build. Ship." )
      end
   end
end


print("hello world")-----------------------------------------------------------------------------------------
