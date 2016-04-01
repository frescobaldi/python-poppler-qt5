#!/usr/bin/env python2.7
import popplerqt5
import PyQt5.QtXml
import argparse
import tempfile
import shutil

def merge(target, src):
    dom=PyQt5.QtXml.QDomDocument()
    for pg_index in range(min(target.numPages(),src.numPages())):
        p_tgt = target.page(pg_index)
        p_src = src.page(pg_index)
        for a in p_src.annotations():
            if not has_annotation(p_tgt,a):
                a_el = dom.createElement("annotation")
                popplerqt5.Poppler.AnnotationUtils.storeAnnotation(a,a_el,dom)
                a_tgt = popplerqt5.Poppler.AnnotationUtils.createAnnotation(a_el)
                p_tgt.addAnnotation(a_tgt)

def has_annotation(page,a):
    for pa in page.annotations():
        if pa.uniqueName() == a.uniqueName():
            return True
    return False
            
def save_pdf(pdf_doc,filename):
    c = pdf_doc.pdfConverter()
    c.setOutputFileName(filename)
    c.setPDFOptions(c.WithChanges)
    c.convert()
    
def load_pdf(filename):
    return popplerqt5.Poppler.Document.load(filename)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='A simple utility for merging pdf annotations')
    parser.add_argument('file', help='the files to merge annotations from', nargs="+")
    parser.add_argument('--output', help='the file to save annotations to (if not present, will save into the first file)')
    args = parser.parse_args()
    tgt = load_pdf(args.file[0])
    for f in args.file[1:]:
        src = load_pdf(f)
        merge(tgt,src)
    if args.output:
        save_pdf(tgt,args.output)
    else:
        tmp_h,tmp_path = tempfile.mkstemp("pdf")
        save_pdf(tgt,tmp_path)
        del tgt
        shutil.move(tmp_path,args.file[0])
        
        
    
    


            
        
        
    
