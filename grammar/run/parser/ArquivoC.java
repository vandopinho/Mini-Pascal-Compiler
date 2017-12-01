
package run.parser;


import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;



public class ArquivoC {
    public static void get(String texto){
        try {
            texto(texto);
        } catch (IOException ex) {}
    }
    public static void texto(String texto) throws IOException {
        File code = new File( "code.cpp" );
        code.delete();
        code.createNewFile();
        FileWriter filew = new FileWriter(code, true);
        BufferedWriter bufferw = new BufferedWriter(filew);
        bufferw.write(texto);
        bufferw.newLine();
        bufferw.close();
        filew.close();
        
    }
}
