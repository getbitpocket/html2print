
{  
  function getPrinterString(input) {
    switch (input) {
      case '<h1>':
        // double height / double width
      	return '\x1b\x21\x10\x1b\x21\x20';      
      case '<br>':
        return '\x0a\x1b\x40';
      case 'bold':
        return '\x1b\x45\x01';      
      case 'underline':
        return '\x1b\x2d\x01';      
      case 'underline2':
        return '\x1b\x2d\x02';      
      case 'align-left':
        return '\x1b\x61\x00';
      case 'align-center':
        return '\x1b\x61\x01';
      case 'align-right':
        return '\x1b\x61\x02';        
      default:
        return '';  
    }
  }  
}

Content
  = (Text / H1 / P / B / BR) *

H1 "Heading"
  = "<h1" styles:StyleAttribute? ">" content:Content "</h1>" {
  	  var start = getPrinterString('<h1>');
      var end = getPrinterString('<br>');
  	  var stylesIn = styles ? styles : '';      
      return start + stylesIn + content.join("") + end;
    }

P "Paragraph"
  = "<p" styles:StyleAttribute? ">" content:Content "</p>" {
  	  var start = getPrinterString('<br>');
      var end = getPrinterString('<br>');
  	  var stylesIn = styles ? styles : '';      
      return start + stylesIn + content.join("") + stylesOut + end;
    }

B "Bold"
  = "<b>" content:Content "</b>" {
  	  var start = getPrinterString('bold');
      var end = getPrinterString('<br>');
      return start + content.join("") + end;
    }

BR "Line Break"
  = "<br" [ ]* (">"/"/>") {
      return getPrinterString("<br>");
    }
    
StyleAttribute "StyleAttribute"
  = [ ]'class="'classes:(("underline"/"underline2"/"bold"/"align-center"/"align-left"/"align-right"/"bold"/"underline"/"emphasis"/[ ])*)'"' {
  	  var classesIn = "";
      
      for (var i = 0; i < classes.length; i++) {
        classesIn += getPrinterString(classes[i].trim());
      }      
            
      return classesIn;  
    }    

Text "Text"
  = text:[a-z0-9A-Z ]+ { return text.join(""); }
  / [\n\r\t] { return ""; }


