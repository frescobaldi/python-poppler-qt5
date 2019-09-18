/*
 * Various conversions that are not made by PyQt5 default.
 */


/**
 * Convert QSet<Poppler::Document::RenderBackend>
 * from any Python sequence and to a Python list.
 */

%MappedType QSet<Poppler::Document::RenderBackend>
{
%TypeHeaderCode
#include <qset.h>
%End

%ConvertFromTypeCode
    // Create the list.
    PyObject *l;

    if ((l = PyList_New(sipCpp->size())) == NULL)
        return NULL;

    // Set the list elements.
    QSet<Poppler::Document::RenderBackend> set = *sipCpp;
    int i = 0;
    foreach (Poppler::Document::RenderBackend value, set)
    {
        PyObject *obj = PyLong_FromLong ((long) value);
        if (obj == NULL || PyList_SetItem(l, i, obj) < 0)
        {
            Py_DECREF(l);

            if (obj)
                Py_DECREF(obj);

            return NULL;
        }

        Py_DECREF(obj);
        i++;
    }
   
    return l;
%End

%ConvertToTypeCode
    // Check the type if that is all that is required.
    if (sipIsErr == NULL)
    {
        if (!PySequence_Check(sipPy))
            return 0;
        return 1;
    }

    QSet<Poppler::Document::RenderBackend> *qs = new QSet<Poppler::Document::RenderBackend>;
 
    for (int i = 0; i < PySequence_Size(sipPy); ++i)
    {
        Poppler::Document::RenderBackend t = (Poppler::Document::RenderBackend)PyLong_AsLong(PySequence_ITEM (sipPy, i));
        *qs << t;
    }
 
    *sipCppPtr = qs;
 
    return sipGetState(sipTransferObj);
%End
};


/**
 * Convert QLinkedList<TYPE> from any sequence and to a Python list.
 */

template<TYPE>
%MappedType QLinkedList<TYPE>
{
%TypeHeaderCode
#include <qlinkedlist.h>
%End

%ConvertFromTypeCode
    // Create the list.
    PyObject *l;

    if ((l = PyList_New(sipCpp->size())) == NULL)
        return NULL;

    // Set the list elements.
    TYPE item;
    QLinkedList<TYPE>::iterator i;
    int index = 0;
    for (i = sipCpp->begin(); i != sipCpp->end(); ++i)
    {
        TYPE *t = new TYPE(*i);
        PyObject *tobj;

        if ((tobj = sipConvertFromNewType(t, sipType_TYPE, sipTransferObj)) == NULL)
        {
            Py_DECREF(l);
            delete t;

            return NULL;
        }

        PyList_SET_ITEM(l, index, tobj);
        ++index;
    }

    return l;
%End

%ConvertToTypeCode
    SIP_SSIZE_T len;

    // Check the type if that is all that is required.
    if (sipIsErr == NULL)
    {
        if (!PySequence_Check(sipPy) || (len = PySequence_Size(sipPy)) < 0)
            return 0;

        for (SIP_SSIZE_T i = 0; i < len; ++i)
        {
            PyObject *itm = PySequence_ITEM(sipPy, i);
            bool ok = (itm && sipCanConvertToType(itm, sipType_TYPE, SIP_NOT_NONE));

            Py_XDECREF(itm);

            if (!ok)
                return 0;
        }

        return 1;
    }

    QLinkedList<TYPE> *qll = new QLinkedList<TYPE>;
    len = PySequence_Size(sipPy);
 
    for (SIP_SSIZE_T i = 0; i < len; ++i)
    {
        PyObject *itm = PySequence_ITEM(sipPy, i);
        int state;
        TYPE *t = reinterpret_cast<TYPE *>(sipConvertToType(itm, sipType_TYPE, sipTransferObj, SIP_NOT_NONE, &state, sipIsErr));

        Py_DECREF(itm);
 
        if (*sipIsErr)
        {
            sipReleaseType(t, sipType_TYPE, state);

            delete qll;
            return 0;
        }

        qll->append(*t);

        sipReleaseType(t, sipType_TYPE, state);
    }
 
    *sipCppPtr = qll;
 
    return sipGetState(sipTransferObj);
%End
};

/**
 * Convert QList<QLinkedList<TYPE>>
 */

template <TYPE>
%MappedType QList< QLinkedList<TYPE> >
{
%TypeHeaderCode
#include <qlist.h>
#include <qlinkedlist.h>
%End

%ConvertFromTypeCode
  // Create the list.
  PyObject *l;

  if ((l = PyList_New(sipCpp->size())) == NULL)
    return NULL;

  const sipMappedType* qlinkedlist_type = sipFindMappedType("QLinkedList<TYPE>");

  // Set the list elements.
  for (int i = 0; i < sipCpp->size(); ++i)
  {
    QLinkedList<TYPE>* t = new QLinkedList<TYPE>(sipCpp->at(i));
    PyObject *tobj;

    if ((tobj = sipConvertFromMappedType(t, qlinkedlist_type, sipTransferObj)) == NULL)
    {
      Py_DECREF(l);
      delete t;
      return NULL;
    }
    PyList_SET_ITEM(l, i, tobj);
  }

  return l;
%End

%ConvertToTypeCode
  const sipMappedType* qlinkedlist_type = sipFindMappedType("QLinkedList<TYPE>");

  // Check the type if that is all that is required.
  if (sipIsErr == NULL)
  {
    if (!PySequence_Check(sipPy))
      return 0;

    for (int i = 0; i < PySequence_Size(sipPy); ++i)
      if (!sipCanConvertToMappedType(PySequence_ITEM(sipPy, i), qlinkedlist_type, SIP_NOT_NONE))
        return 0;

    return 1;
  }


  QList< QLinkedList<TYPE> > *ql = new QList< QLinkedList<TYPE> >;

  for (int i = 0; i < PySequence_Size(sipPy); ++i)
  {
    int state;
    QLinkedList<TYPE> * t = reinterpret_cast< QLinkedList<TYPE> * >(sipConvertToMappedType(PySequence_ITEM(sipPy, i), qlinkedlist_type, sipTransferObj, SIP_NOT_NONE, &state, sipIsErr));

    if (*sipIsErr)
    {
      sipReleaseInstance(t, sipClass_TYPE, state);
      delete ql;
      return 0;
    }
    ql->append(*t);
    sipReleaseInstance(t, sipClass_TYPE, state);
  }

  *sipCppPtr = ql;
  return sipGetState(sipTransferObj);
%End

};

/**
 * Convert time_t to and from long integer
 */

%MappedType time_t
{
%TypeHeaderCode
#include <time.h>
%End

%ConvertFromTypeCode
    PyObject* pTime;
    pTime = PyLong_FromLong(*sipCpp);  
    return pTime;
%End

%ConvertToTypeCode
    if (sipIsErr == NULL)
    {
        return PyLong_Check(sipPy);
    }

    if (sipPy == Py_None)
    {
        *sipCppPtr = new long();
        return 1;
    }

    if (PyLong_Check(sipPy))
    {
        *sipCppPtr = new long(PyLong_AsLong(sipPy)); 
        return 1;
    }
    return 0;
%End
};

/**
 * Convert to and from QList<qint64>
 */
 
%MappedType QList<qint64>
{
%TypeHeaderCode
#include <QList>
%End

%ConvertFromTypeCode
  // Create the list.
  PyObject *l;

  if ((l = PyList_New(sipCpp->size())) == NULL)
    return NULL;

  // Set the list elements.
  QList<qint64>::iterator it = sipCpp->begin();
  for (int i = 0; it != sipCpp->end(); ++it, ++i)
  {
    PyObject *tobj;

    if ((tobj = PyLong_FromLongLong(*it)) == NULL)
    {
      Py_DECREF(l);
      return NULL;
    }
    PyList_SET_ITEM(l, i, tobj);
  }

  return l;
%End

%ConvertToTypeCode
  // Check the type if that is all that is required.
  if (sipIsErr == NULL)
    return PyList_Check(sipPy);

  QList<qint64> *qlist = new QList<qint64>;

  for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i)
  {
    *qlist << PyLong_AsLongLong(PyList_GET_ITEM(sipPy, i));
  }

  *sipCppPtr = qlist;
  return sipGetState(sipTransferObj);
%End
};



/* kate: indent-width 4; space-indent on; hl c++; indent-mode cstyle; */
