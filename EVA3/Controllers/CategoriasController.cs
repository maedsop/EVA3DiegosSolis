using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EVA3.Models;

namespace Tarea1.Controllers
{
    public class CategoriasController : Controller
    {
        EVA3.Models.Tarea1Entities contexto = new EVA3.Models.Tarea1Entities();
        // GET: Categorias
        public ActionResult Index()
        {
            if (Session["Usuario"] != null)
            {
                var cat = contexto.Categoria.ToList();
                return View(cat);
            }
            else
            {
                return RedirectToAction("Index", "Productos");
            }
        }

        public ActionResult Eliminar(int id)
        {
            if (Session["Usuario"] != null)
            {
                var cat = (from c in contexto.Categoria where c.Id == id select c).FirstOrDefault();

                contexto.Categoria.Remove(cat);

                contexto.SaveChanges();

                return RedirectToAction("Index");
            }
            else
            {
                return RedirectToAction("Index", "Productos");
            }
        }

        public ActionResult Guardar()
        {
            string mensaje = "";
            var id = Request["idCategoria"];
            var nombre = Request["nombre"];

            Categoria c = new Categoria();
            c.Id = int.Parse(id);
            c.Nombre = nombre;

            try
            {
                contexto.Categoria.Add(c);
                contexto.SaveChanges();
                mensaje = "Guardado con exito";
            }
            catch (Exception ex)
            {
                mensaje = "Error al guardar el dato";
            }
            ViewBag.mensaje = mensaje;

            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int id)
        {
            var cat = (from c in contexto.Categoria where c.Id == id select c).FirstOrDefault();

            if (cat != null)
            {
                return View(cat);
            }
            else
                return RedirectToAction("Index");
        }

        public ActionResult GuardarModificar()
        {
            int id = int.Parse(Request["idCategoria"]);
            var nombre = Request["nombre"];

            Categoria cat = (from c in contexto.Categoria where c.Id == id select c).FirstOrDefault();
            if (cat != null)
            {
                cat.Nombre = nombre;
                contexto.SaveChanges();
            }

            return RedirectToAction("Index");
        }
    }
}