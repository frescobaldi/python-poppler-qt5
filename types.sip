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

  const sipTypeDef* qlinkedlist_type = sipFindType("QLinkedList<TYPE>");

  // Set the list elements.
  for (int i = 0; i < sipCpp->size(); ++i)
  {
    QLinkedList<TYPE>* t = new QLinkedList<TYPE>(sipCpp->at(i));
    PyObject *tobj;

    if ((tobj = sipConvertFromType(t, qlinkedlist_type, sipTransferObj)) == NULL)
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
  const sipTypeDef* qlinkedlist_type = sipFindType("QLinkedList<TYPE>");

  // Check the type if that is all that is required.
  if (sipIsErr == NULL)
  {
    if (!PySequence_Check(sipPy))
      return 0;

    for (int i = 0; i < PySequence_Size(sipPy); ++i)
      if (!sipCanConvertToType(PySequence_ITEM(sipPy, i), qlinkedlist_type, SIP_NOT_NONE))
        return 0;

    return 1;
  }


  QList< QLinkedList<TYPE> > *ql = new QList< QLinkedList<TYPE> >;

  for (int i = 0; i < PySequence_Size(sipPy); ++i)
  {
    int state;
    QLinkedList<TYPE> * t = reinterpret_cast< QLinkedList<TYPE> * >(sipConvertToType(PySequence_ITEM(sipPy, i), qlinkedlist_type, sipTransferObj, SIP_NOT_NONE, &state, sipIsErr));

    if (*sipIsErr)
    {
      sipReleaseType(t, qlinkedlist_type, state);
      delete ql;
      return 0;
    }
    ql->append(*t);
    sipReleaseType(t, qlinkedlist_type, state);
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
        *sipCppPtr = new time_t();
        return 1;
    }

    if (PyLong_Check(sipPy))
    {
        *sipCppPtr = new time_t(PyLong_AsLong(sipPy));
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


/**
 * Convert QVector< QPair<TYPE, TYPE> >
 * from and to a Python list of a 2-item tuple
 */

template<TYPE>
%MappedType QVector< QPair<TYPE, TYPE> >
{
%TypeHeaderCode
#include <qvector.h>
#include <qpair.h>
%End

%ConvertFromTypeCode
  // Create the list.
  PyObject *l;

  if ((l = PyList_New(sipCpp->size())) == NULL)
      return NULL;

  // Set the list elements.
  for (int i = 0; i < sipCpp->size(); ++i)
  {
    QPair<TYPE, TYPE>* p = new QPair<TYPE, TYPE>(sipCpp->at(i));
    PyObject *ptuple = PyTuple_New(2);
    PyObject *pfirst;
    PyObject *psecond;

    TYPE *sfirst = new TYPE(p->first);
    if ((pfirst = sipConvertFromType(sfirst, sipType_TYPE, sipTransferObj)) == NULL)
    {
      Py_DECREF(l);
      Py_DECREF(ptuple);
      return NULL;
    }
    PyTuple_SET_ITEM(ptuple, 0, pfirst);

    TYPE *ssecond = new TYPE(p->second);
    if ((psecond = sipConvertFromType(ssecond, sipType_TYPE, sipTransferObj)) == NULL)
    {
      Py_DECREF(l);
      Py_DECREF(ptuple);
      Py_DECREF(pfirst);
      return NULL;
    }
    PyTuple_SET_ITEM(ptuple, 1, psecond);

    PyList_SET_ITEM(l, i, ptuple);
  }

  return l;
%End

%ConvertToTypeCode
  const sipTypeDef* qpair_type = sipFindType("QPair<TYPE, TYPE>");

  // Check the type if that is all that is required.
  if (sipIsErr == NULL)
  {
    if (!PySequence_Check(sipPy))
      return 0;

    for (int i = 0; i < PySequence_Size(sipPy); ++i)
      if (!sipCanConvertToType(PySequence_ITEM(sipPy, i), qpair_type, SIP_NOT_NONE))
        return 0;

    return 1;
  }


  QVector< QPair<TYPE, TYPE> > *qv = new QVector< QPair<TYPE, TYPE> >;

  for (int i = 0; i < PySequence_Size(sipPy); ++i)
  {
    int state;
    QPair<TYPE, TYPE> * p = reinterpret_cast< QPair<TYPE, TYPE> * >(sipConvertToType(PySequence_ITEM(sipPy, i), qpair_type, sipTransferObj, SIP_NOT_NONE, &state, sipIsErr));

    if (*sipIsErr)
    {
      sipReleaseType(p, qpair_type, state);
      delete qv;
      return 0;
    }
    qv->append(*p);
    sipReleaseType(p, qpair_type, state);
  }

  *sipCppPtr = qv;
  return sipGetState(sipTransferObj);
%End

};


/* kate: indent-width 4; space-indent on; hl c++; indent-mode cstyle; */
